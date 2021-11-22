# frozen_string_literal: true

module Publishers
  class BasePublisher
    include Wisper::Publisher

    attr_reader :action

    def initialize(action: [])
      @action = action
    end

    def call
      fetch_actions.index_with do |current_action|
        publish(current_action, *args) if events[current_action].call(*args)
      end
    end

    private

    def args
      []
    end

    def events
      {}
    end

    def fetch_actions
      action.is_a?(Array) ? action : [action]
    end
  end
end
