# frozen_string_literal: true

def stub_jwt_verification(controller:, payload: {})
  activating = payload.delete(:active)
  user = stub_user(payload, active: activating)
  allow_any_instance_of(controller).to receive(:auth_token).and_return({ 'user_id' => user.id })
  user
end

def stub_user(data, active:)
  options = [active, data].compact
  create(:user, *options)
end
