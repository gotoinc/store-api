# frozen_string_literal: true

module Publishers
  class NotificationPublisher < BasePublisher

    attr_reader :customer, :admin, :resource

    def initialize(action:, admin: nil, customer: nil, resource: nil)
      super(action: action)
      @customer = customer
      @admin = admin
      @resource = resource
    end

    private

    def args
      [customer, admin, resource]
    end

    def events
      @events ||= Notifications::Item::NOTIFICATION_KINDS.index_with { proc { true } }
      @events.merge!({ init_channel: proc { true } })
    end
  end
end
