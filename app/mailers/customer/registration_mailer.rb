# frozen_string_literal: true

module Customer
  class RegistrationMailer < ApplicationMailer

    default from: AdditionalData::SUPPORT_EMAIL, reply_to: AdditionalData::EMAIL_REPLY_TO

    def email_confirmation(customer)
      @customer = customer

      mail to: "#{@customer.first_name} <#{@customer.email}>",
           subject: 'Confirm your email.'
    end

    def password_reset(customer)
      @customer = customer

      mail to: "#{@customer.first_name} <#{@customer.email}>",
           subject: 'Password retrieval.'
    end
  end
end
