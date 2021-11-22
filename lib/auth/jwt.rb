# frozen_string_literal: true

module Auth
  class Jwt

    def self.encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, ENV.fetch('SECRET_KEY_BASE'))
    end

    def self.decode(token)
      decoded = JWT.decode(token, ENV.fetch('SECRET_KEY_BASE')).first
      HashWithIndifferentAccess.new decoded
    end
  end
end
