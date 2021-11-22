# frozen_string_literal: true

module Abilities
  class Customer < Ability

    def initialize(user)
      super

      can %i[index show create], Product
    end
  end
end
