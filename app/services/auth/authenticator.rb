# frozen_string_literal: true

module Auth
  class Authenticator
    attr_accessor :resource

    def initialize(email:, password:)
      @email = email
      @password = password
      @resource = User.activated.find_by(email: email)
    end

    def valid?
      resource.present? && resource.valid_password?(password)
    end

    private

    attr_reader :email, :password
  end
end
