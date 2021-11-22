# frozen_string_literal: true

module Notifiers
  module Customer
    class InactiveUserJob < Base
      sidekiq_options queue: :notifiers

      def perform(customer_id)
        user = User.customer.find_by(id: customer_id)

        return if user.blank?

        project = user.active_project

        return if project.blank? || !project.vacant? || (project.incomplete? && !project.can_be_send_to_admin?)

        ::Customer::DocumentMailer.documents_awaiting(user).deliver_later
        # Will call this worker again after 1 instead 2 days
        self.class.perform_at(Time.zone.now + 1.day, user.id)
      end
    end
  end
end
