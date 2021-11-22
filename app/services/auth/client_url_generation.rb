# frozen_string_literal: true

module Auth
  class ClientUrlGeneration

    attr_reader :token, :user

    def initialize(token:, user:)
      @token = token
      @user = user
    end

    def call
      return '/' if token.blank? || user.blank?

      url = URI.parse(ENV.fetch("#{user.role.upcase}_APP_URL", '/'))
      url.path = "/reset-password/#{token}"
      url.to_s
    end
  end
end
