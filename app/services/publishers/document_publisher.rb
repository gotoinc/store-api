# frozen_string_literal: true

module Publishers
  class DocumentPublisher < BasePublisher

    attr_reader :user, :document

    def initialize(action:, document:)
      super(action: action)
      @document = document
      @user = document.user
    end

    private

    def args
      [user, document]
    end

    def events
      { send_rejecting_email: ->(user, document) { user.customer? && document.rejected? } }
    end
  end
end
