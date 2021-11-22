# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    include ActionView::Helpers::TranslationHelper
    include Auth::Concerns::Secured
    include Concerns::ErrorHandler
    include ActiveStorage::SetCurrent

    # check_authorization
    before_action :authenticate_request!

    private

    # @override
    def current_ability
      @current_ability ||= Abilities::Factory.build(current_user)
    end

    def json_api_error_response(status: 401, message: 'Email or Password is invalid')
      {
        errors: [
          {
            status: status,
            title: message
          }
        ]
      }
    end
  end
end
