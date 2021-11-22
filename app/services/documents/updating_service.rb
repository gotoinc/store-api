# frozen_string_literal: true

module Documents
  class UpdatingService

    attr_reader :params, :document, :initiator

    def initialize(params:, document:, initiator: nil)
      @params = params
      @document = document
      @initiator = initiator
    end

    def call
      return document if document.approved?

      version = Documents::VersioningService.new({ document: document, initiator: initiator, params: params }).call

      version.destroy && raise(ActiveRecord::RecordInvalid.new(document)) unless file_valid?

      document.assign_attributes(document_params)

      yield(document) if block_given?

      document.save!

      document
    end

    private

    def file_params
      params[:file]
    end

    def document_params
      params[:document].permit(:name)
    end

    def object_valid?
      file_valid? && document.valid?
    end

    def file_valid?
      return true if file_params.blank?

      document.file.attach(file_params)
    end
  end
end
