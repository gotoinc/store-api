# frozen_string_literal: true

module Documents
  class VersioningService

    attr_reader :initiator, :document, :params

    def initialize(initiator:, document:, params:)
      @initiator = initiator
      @document = document
      @params = params
    end

    def call
      return new_version if document.approved? || document.errors.any?

      version = document.versions.build(version_params)
      version.file.attach(file.blob) if file_params.present? && file.attached?
      version.save!

      version
    end

    private

    def version_params
      document.attributes.slice('status', 'name')
              .merge(event: params.fetch(:action, :update))
              .merge(comment: comment)
              .merge(initiator: initiator)
    end

    def comment
      params.dig(:document, :comment)
    end

    def file_params
      params[:file]
    end

    def file
      document.file
    end

    def new_version
      DocumentVersion.new
    end
  end
end
