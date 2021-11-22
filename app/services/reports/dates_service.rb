# frozen_string_literal: true

module Reports
  class DatesService

    attr_reader :project

    def initialize(project:)
      @project = project
    end

    def call
      draft_start_date if report.draft?
      draft_end_date if report.approved?
      report_start_date if report.report? && project.report_start.blank?
      report_end_date if report.report_approved?

      project.save!
      project
    end

    private

    def draft_start_date
      project.draft_start = project.report.created_at.to_s
    end

    def draft_end_date
      project.draft_end = update_date
    end

    def report_start_date
      project.report_start = update_date
    end

    def report_end_date
      project.report_end = update_date
    end

    def report
      project.report
    end

    def update_date
      project.report.updated_at.to_s
    end
  end
end
