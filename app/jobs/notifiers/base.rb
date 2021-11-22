# frozen_string_literal: true

module Notifiers
  class Base
    # include Sidekiq::Worker

    sidekiq_options queue: :notifiers
  end
end
