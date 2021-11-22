# frozen_string_literal: true

module Abilities
  class Admin < Ability

    def initialize(_user)
      super

      can %i[index show update], Product, :all
      can :create, Category, :all
    end
  end
end
