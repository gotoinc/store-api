# frozen_string_literal: true

module Abilities
  class Provider < Ability

    def initialize(user)
      super

      can %i[index show create destroy], Product, user_id: user.id
      # can :update, { |record| record.user_id == user.id }
      can %i[index create], Category
    end
  end
end
