# frozen_string_literal: true

module Auth
  class RegistrationsController < Api::ApplicationController

    skip_authorize_resource
    skip_before_action :authenticate_request!

    def create
      raise ActiveRecord::RecordNotSaved.new('Invalid password.') unless password_valid?

      @user = User.create!(user_params)

      render json: AuthSerializer.new(@user)
    end

    private

    def user_params
      @user_params ||= params.permit(:first_name,
                                     :last_name,
                                     :email,
                                     :password,
                                     :password_confirmation)
    end

    def token(resource)
      Auth::Jwt.encode(user_id: resource.id)
    end

    def password_valid?
      User.check_password(user_params[:password])
    end
  end
end
