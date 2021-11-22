# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do
  it 'Controller check' do
    expect(methods.count).to be >= ApplicationController.methods.count
  end
end
