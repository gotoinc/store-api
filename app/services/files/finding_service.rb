# frozen_string_literal: true

module Files
  class FindingService

    WHITELIST_SOURCES = {
      'Document' => 'uuid',
      'DocumentVersion' => 'id',
      'Report' => 'uuid',
      'Archive' => 'uuid'
    }.freeze
    WHITELIST_FILE_TYPES = %w[blank sample file draft report].freeze

    attr_reader :params

    def initialize(params: {})
      @params = params
    end

    def call
      return empty_attachment if params.blank? || restricted? || resource_id.blank?

      file
    end

    private

    def file
      resource.public_send(file_type)
    end

    def empty_attachment
      ActiveStorage::Attached::One.new(file_type, resource_type.new)
    end

    def resource_type
      params.fetch(:resource_type, 'documents').to_s.classify
    end

    def file_type
      params.fetch(:file_type, 'file')
    end

    def resource
      @resource ||= resource_type.safe_constantize.find_by!(WHITELIST_SOURCES[resource_type] => resource_id)
    end

    def resource_id
      params.fetch(:resource_id, nil)
    end

    def restricted?
      WHITELIST_SOURCES.keys.exclude?(resource_type) || WHITELIST_FILE_TYPES.exclude?(file_type)
    end
  end
end
