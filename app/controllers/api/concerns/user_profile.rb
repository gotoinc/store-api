# frozen_string_literal: true

module Api
  module Concerns
    module UserProfile
      extend ActiveSupport::Concern

      def show
        render json: UserSerializer.new(current_user)
      end

      def update
        user = Users::UpdatingService.new(params: user_params, user: current_user).call

        render json: UserSerializer.new(user)
      end

      private

      def user_params
        params.permit(:first_name,
                      :last_name,
                      :email,
                      :current_password,
                      :password,
                      :password_confirmation,
                      :onboarded,
                      :photo)
      end
    end
  end
end
