# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  prepend_view_path 'app/views/mailers'
  layout 'mailer'
end
