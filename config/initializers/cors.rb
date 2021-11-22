# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  %w[ADMIN_APP_URL CUSTOMER_APP_URL].map do |k|
    u = URI.parse(ENV.fetch(k))

    allow do
      builder = { 'http' => URI::HTTP, 'https' => URI::HTTPS }[u.scheme]

      origins builder.build(host: u.host, port: u.port, scheme: u.scheme).to_s

      resource '*',
               headers: :any,
               methods: %i[get post put patch options head delete],
               expose: %w[access-token expiry uuid Authorization]
    end
  end
end
