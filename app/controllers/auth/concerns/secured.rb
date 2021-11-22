# frozen_string_literal: true

module Auth
  module Concerns
    module Secured
      extend ActiveSupport::Concern

      attr_reader :current_user

      included do
        before_action :authenticate_request!
      end

      private

      def http_token
        return if request.headers['Authorization'].blank?

        request.headers['Authorization'].split.last
      end

      def auth_token
        Auth::Jwt.decode(http_token)
      end

      def authenticate_request!
        @current_user = User.activated.find(auth_token['user_id'])
      rescue JWT::VerificationError, JWT::DecodeError, ActiveRecord::RecordNotFound
        render json: { error: true, messages: [I18n.t('exceptions.not_authenticated')] }, status: :unauthorized
      end
    end
  end
end
