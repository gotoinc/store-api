# frozen_string_literal: true

module Users
  class UpdatingService

    SECURITY_KEYS = %w[current_password password password_confirmation].freeze

    attr_reader :params, :user

    def initialize(params:, user:)
      @params = params
      @user = user
    end

    def call
      if password_params.present?
        password_valid? ? update_password : password_error
      end

      attach_photo if photo_params.present?

      user.assign_attributes(params)
      user.save!

      user
    end

    private

    def security_params
      @security_params ||= params.to_h.each_with_object(ActionController::Parameters.new) do |(key, _), obj|
        obj[key] = params.delete(key) if SECURITY_KEYS.include?(key)
      end.permit!
    end

    def need_password_update?
      security_params.keys.size == SECURITY_KEYS.size
    end

    def password_valid?
      User.check_password(password_params)
    end

    def password_error
      raise ActiveRecord::RecordNotSaved.new('Invalid password.')
    end

    def update_password
      password_error if need_password_update? && !user.update_with_password(security_params)
    end

    def password_params
      params[:password]
    end

    def attach_photo
      raise ActiveRecord::RecordInvalid.new(user) unless user.photo.attach(photo_params)

      user.photo.variant(resize_to_fill: [128, 128]).process
    end

    def photo_params
      params[:photo]
    end
  end
end
