# frozen_string_literal: true

module Api
  module V1
    module Provider
      class UsersController < ApplicationController
        include Concerns::UserProfile
      end
    end
  end
end
