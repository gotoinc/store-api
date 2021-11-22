# frozen_string_literal: true

module Invitations
  class CreationService

    attr_reader :report, :url, :user

    def initialize(report, url, user)
      @report = report
      @url = url
      @user = user
    end

    def call
      invitation = report.invitations.build(url: url)
      invitation.customer = report.project.user
      invitation.admin = user
      invitation.save!
      invitation
    end
  end
end
