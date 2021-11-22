# frozen_string_literal: true

module Abilities
  class Factory

    def self.build(user)
      {
        # Should be implemented later
        'admin' => Abilities::Admin.new(user),
        'customer' => Abilities::Customer.new(user),
        'provider' => Abilities::Provider.new(user)
      }[user.role]
    end
  end
end
