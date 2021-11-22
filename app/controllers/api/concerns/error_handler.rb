# frozen_string_literal: true

module Api
  module Concerns
    module ErrorHandler
      extend ActiveSupport::Concern

      class AuthorizationException < StandardError; end

      ERRORS = {
        bad_request: [
          ActiveRecord::StatementInvalid,
          ActionController::ParameterMissing,
          ArgumentError
        ],
        not_found: [
          ActiveRecord::RecordNotFound
        ],
        unprocessable_entity: [
          ActiveModel::StrictValidationFailed,
          ActiveRecord::RecordInvalid,
          ActiveRecord::RecordNotSaved,
          ActiveRecord::RecordNotDestroyed,
          AASM::InvalidTransition
        ],
        unauthorized: [
          AuthorizationException
        ],
        forbidden: [
          CanCan::AccessDenied
        ]
      }.freeze

      included do
        ERRORS.each_pair do |status, errors|
          rescue_from(*errors, with: ->(error) {
                                       render_exception(error, status: status, messages: extract_messages(error))
                                     })
        end
      end

      def render_exception(error, status:, messages: [])
        render json: { key: error.class.name, messages: messages, error: true }, status: status
      end

      def extract_messages(error)
        if error.is_a? ActiveRecord::RecordNotFound
          I18n.t('activerecord.exceptions.not_found', klass: error.model.to_s.downcase)
        elsif error.try(:record).present? && error.record.is_a?(ActiveRecord::Base)
          error.record.errors.map(&:full_message)
        else
          [error.message]
        end
      end
    end
  end
end
