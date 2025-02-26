# frozen_string_literal: true

module ActivityActionValidators
  class AlertValidator < BaseValidator
    def validate(record)
      details = record.details
      record.errors.add('details.recipients', "can't be blank") if details['recipients'].blank?
      record.errors.add('details.recipients', 'should be an array') unless details['recipients'].is_a?(Array)
      return if valid_recipients?(details['recipients'])

      record.errors.add(:details, 'recipients must only contain integers or numeric strings')
    end

    private

    def valid_recipients?(recipients)
      return false unless recipients.is_a?(Array)

      recipients&.all? do |recipient|
        recipient.is_a?(Integer) || (recipient.is_a?(String) && recipient.match?(/^\d+$/))
      end
    end
  end
end
