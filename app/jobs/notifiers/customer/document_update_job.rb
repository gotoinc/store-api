# frozen_string_literal: true

module Notifiers
  module Customer
    class DocumentUpdateJob < Base

      def perform(customer_id, document_id)
        user = User.customer.find(customer_id)
        document = user.documents.find(document_id)

        return if document.blank? || !document.rejected?

        ::Customer::DocumentMailer.documents_issues(user, document).deliver_now

        # Will call this worker again after 1 day
        self.class.perform_at(Time.zone.now + 1.day, customer_id, document_id)
      end
    end
  end
end
