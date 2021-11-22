# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::Authenticator do
  describe 'Check auth user' do
    let(:user) { create(:user, password: 'password', email: 'example@mail.com') }
    let(:subject) { described_class.new(email: user.email, password: 'password') }

    it '#valid? returns true' do
      expect(subject.valid?).to be_truthy
    end

    it '#valid? returns false' do
      expect(described_class.new(email: '', password: '').valid?).to be_falsey
    end
  end
end
