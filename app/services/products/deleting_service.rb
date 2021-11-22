# frozen_string_literal: true

module Analysts
  class DeletingService

    attr_reader :analyst

    def initialize(analyst:)
      @analyst = analyst
    end

    def call
      analyst.destroy
    end
  end
end
