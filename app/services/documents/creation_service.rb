# frozen_string_literal: true

module Documents
  class CreationService

    attr_reader :params, :project

    def initialize(params:, project:)
      @params = params
      @project = project
    end

    def call
      document = project.documents.build(document_params)
      document.file.attach(file_params)
      document.status = document.file.attached? && 1 || 0
      document.name ||= file_params.original_filename
      document.save!
      document
    end

    private

    def file_params
      params[:file]
    end

    def document_params
      params[:document]&.permit(:name, :status).presence || {}
    end
  end
end
