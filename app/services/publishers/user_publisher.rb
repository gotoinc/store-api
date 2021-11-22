# frozen_string_literal: true

module Publishers
  class UserPublisher < BasePublisher

    attr_reader :user

    def initialize(action:, user:)
      super(action: action)
      @user = user
    end

    private

    def args
      [user]
    end

    def events
      {
        confirm_payment: ->(user) { user.active_invoice.present? && user.active_invoice.paid? },
        init_project: ->(user) { user.customer? && user.active_project.blank? },
        inactive_user_notifier: ->(user) { user.customer? && user.active? },
        registration_notifier: ->(user) { user.present? && user.customer? }
      }
    end
  end
end
