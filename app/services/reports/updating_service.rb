# frozen_string_literal: true

module Reports
  class UpdatingService

    STATUS_SCOPES = {
      draft: %i[vacant draft rejected],
      report: %i[approved report report_rejected report_approved]
    }.freeze

    attr_reader :params, :report

    def initialize(params:, report:)
      @params = params
      @report = report
    end

    def call
      admin_resolve? ? resolve_draft : report.assign_attributes(report_params)

      attach_file if file_params.present?
      switch_status

      report.save!

      report
    end

    private

    def attach_file
      blocked = {
        approved: :draft,
        report_approved: :report
      }[report.status.to_sym]

      return if blocked == active_status

      current_file = report.public_send(active_status)

      raise ActiveRecord::RecordInvalid.new(report) unless current_file.attach(file_params)
    end

    def switch_status
      attach_event_name = "upload_#{active_status}"
      guard_method_name = "may_#{attach_event_name}"

      report.aasm.fire(attach_event_name) if report.public_send("#{guard_method_name}?")
    end

    def active_status
      @active_status = report? ? :report : :draft
    end

    def report?
      STATUS_SCOPES[:report].include?(report.status.to_sym)
    end

    def draft_uploaded?
      report.project.status.to_sym == Project::STATE_DRAFT
    end

    def report_uploaded?
      report.project.status.to_sym == Project::STATE_REPORT
    end

    def file_params
      params[:file]
    end

    def report_params
      params.require(:report).permit(:name, :price, :comment, :archive_url)
    end

    def admin_status
      params[:admin_status]
    end

    def admin_resolve?
      report.rejected? && admin_status.present? && admin_status == 'resolved'
    end

    def resolve_draft
      report.aasm.fire(:resolve_draft)
    end
  end
end
