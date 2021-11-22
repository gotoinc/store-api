# frozen_string_literal: true

require 'zip/zip'
require 'zip/zipfilesystem'
require 'open-uri'

module Zips
  class ArchivingService

    attr_reader :project, :current_document

    def initialize(project:)
      @project = project
    end

    def call
      ::Zip::ZipOutputStream.open(tmp_zip.path) do |zip|
        documents.each_with_index do |document, index|
          next unless document.file.attached?

          @current_document = document

          file_options = prepare_filename(index: index.next)
          # Create a new entry with some arbitrary name
          zip.put_next_entry(file_options[:filename])
          # Add the contents of the file, don't read the stuff linewise if its binary, instead use direct IO

          zip.print document.file.open &:read
        end
      end

      File.open(tmp_zip.path)
    ensure
      tmp_zip.close
      tmp_zip.unlink
    end

    private

    def documents
      project.documents.approved
    end

    def tmp_zip
      @tmp_zip ||= Tempfile.new([project.uuid, '.zip'])
    end

    def prepare_filename(index:)
      {
        extension: extension,
        basename: basename(index),
        filename: filename(index)
      }
    end

    def extension
      ActiveStorage::Filename.new(document_blob.filename.to_s).extension_with_delimiter
    end

    def basename(index)
      {
        true => ->(i, document) { "#{document.name}-(#{i})" },
        false => ->(i, document) { "#{ActiveStorage::Filename.new(document.file.filename.to_s).base}-(#{i})" }
      }[current_document.required?].call(index, current_document)
    end

    def filename(index)
      "#{basename(index)}#{extension}"
    end

    def document_blob
      current_document.file.attachment.blob
    end
  end
end
