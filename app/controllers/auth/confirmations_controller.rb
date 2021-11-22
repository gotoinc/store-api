# frozen_string_literal: true

module Auth
  class ConfirmationsController < Api::ApplicationController

    skip_authorize_resource
    skip_before_action :authenticate_request!

    def show
      @user = User.confirm_by_token(confirmation_token)

      raise ActiveRecord::RecordNotFound if @user.new_record?

      redirect_to root_path
    end

    def create
      unconfirmed_user.send_confirmation_instructions

      render json: { messages: [I18n.t('devise.confirmations.send_instructions')] }
    end

    private

    def email_params
      params.fetch(:email)
    end

    def confirmation_token
      params.fetch(:confirmation_token)
    end

    def unconfirmed_user
      @unconfirmed_user = User.where(confirmed_at: nil).find_by!(email: email_params)
    end
  end
end
