# frozen_string_literal: true

module Auth
  class PasswordsController < Api::ApplicationController
    skip_authorize_resource
    skip_before_action :authenticate_request!

    def create
      resource.nil? ? email_error : resource.send_reset_password_instructions

      render json: { messages: [I18n.t('devise.passwords.send_instructions')] }
    end

    def update
      password_valid? ? reset_password : password_error

      raise ActiveRecord::RecordNotFound if resource.new_record?

      render json: { messages: [I18n.t('devise.passwords.updated_not_active')] }
    end

    private

    def resource
      @resource ||= User.activated.find_by(email: email_params)
    end

    def email_params
      params.fetch(:email)
    end

    def reset_password_params
      params.permit(:reset_password_token, :password, :password_confirmation)
    end

    def password_valid?
      User.check_password(reset_password_params[:password])
    end

    def password_error
      raise ActiveRecord::RecordNotSaved.new('Invalid password.')
    end

    def email_error
      raise ActiveRecord::RecordNotSaved.new('Invalid email.')
    end

    def reset_password
      @resource = User.reset_password_by_token(reset_password_params)
    end
  end
end
