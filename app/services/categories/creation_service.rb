# frozen_string_literal: true

module Categories
  class CreationService

    attr_reader :params

    def initialize(params:)
      @params = params
    end

    def call
      analyst = ::Category.new(params)
      analyst.save!
      analyst
    end
  end
end
