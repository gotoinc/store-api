# frozen_string_literal: true

module Api
  module V1
    module Provider
      class ApplicationController < Api::ApplicationController

        def authenticate_request!
          @current_user = User.activated.provider.find(auth_token['user_id'])
        rescue JWT::VerificationError, JWT::DecodeError, ActiveRecord::RecordNotFound
          render json: { errors: [I18n.t('exceptions.not_authenticated')] }, status: :unauthorized
        end
      end
    end
  end
end
