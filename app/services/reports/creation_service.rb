# frozen_string_literal: true

module Reports
  class CreationService

    attr_reader :params, :project

    def initialize(params:, project:)
      @params = params
      @project = project
    end

    def call
      report = project.build_report(report_params)
      raise ActiveRecord::RecordInvalid.new(report) unless report.draft.attach(file_params)

      report.name ||= file_params.original_filename
      report.save!

      report
    end

    private

    def file_params
      params[:file]
    end

    def report_params
      params[:report]&.permit(:name, :price).presence || {}
    end
  end
end
