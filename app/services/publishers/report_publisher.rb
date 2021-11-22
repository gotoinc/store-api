# frozen_string_literal: true

module Publishers
  class ReportPublisher < BasePublisher

    attr_reader :report

    def initialize(action:, report:)
      super(action: action)
      @report = report
    end

    private

    def args
      [report]
    end

    def events
      {
        update_date: ->(report) { report.project.present? },
        clarification_notifier: ->(report) { report.rejected? },
        resolving_notifier: ->(report) { report.draft? },
        approving_notifier: ->(report) { report.project.draft? },
        report_approving_notifier: ->(report) { report.project.report? }
      }
    end
  end
end
