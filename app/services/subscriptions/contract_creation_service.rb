# frozen_string_literal: true

module Subscriptions
  class ContractCreationService

    attr_reader :project, :params

    def initialize(project, params = {})
      @project = project
      @params = params
    end

    def call
      contract = project.build_contract(params)

      # Hardcoded the first subscription unless Zoho integration was implemented
      contract.subscription = Subscription.first
      contract.save!
      contract
    end
  end
end
