# frozen_string_literal: true

module Publishers
  class AuthPublisher < BasePublisher

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
        send_confirmation_email: ->(user) { user.confirmed_at.blank? }
      }
    end
  end
end
