# frozen_string_literal: true

module Auth
  class SessionsController < Api::ApplicationController
    skip_before_action :authenticate_request!
    skip_authorize_resource

    def create
      authenticator = Auth::Authenticator.new(email: email, password: password)

      raise Api::Concerns::ErrorHandler::AuthorizationException.new(error_message) unless authenticator.valid?

      render json: UserSerializer.new(authenticator.resource,
                                      include: %w[cart cart.cart_items],
                                      meta: { auth_token: token(authenticator.resource) })
    end

    private

    def error_message
      I18n.t('auth.sessions.error_message')
    end

    def email
      session_params[:email]
    end

    def password
      session_params[:password]
    end

    def session_params
      @session_params ||= params.permit(:email, :password)
    end

    def token(resource)
      Auth::Jwt.encode(user_id: resource.id)
    end
  end
end
