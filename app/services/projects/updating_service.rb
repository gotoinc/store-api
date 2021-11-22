# frozen_string_literal: true

module Projects
  class UpdatingService

    attr_reader :params, :project

    def initialize(params:, project:)
      @params = params
      @project = project
    end

    def call
      set_valuation if valuation_params.present?

      project.assign_attributes(project_params)
      project.save!
      project
    end

    private

    def valuation_params
      params[:valuation_date]
    end

    # temporary disabled
    # def valuation_blank?
    #   project.valuation_date.blank? && project.expiration_date.blank?
    # end

    def set_valuation
      project.valuation_date = valuation_params
      project.expiration_date = Date.parse(valuation_params).next_year.to_s

      valuation_update_notification if project.admin_valuation_update?
    end

    def valuation_update_notification
      Customer::ReportMailer.valuation_date_updated(project).deliver_now
    end

    def project_params
      params.permit(:status, :analyst_id, :admin_valuation_update)
    end
  end
end
