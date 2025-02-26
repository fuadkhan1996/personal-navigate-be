# frozen_string_literal: true

module ActivityActionValidators
  class FileUploadValidator < BaseValidator
    def validate(record)
      details = record.details
      record.errors.add('details.allowed_file_types', "can't be blank") if details['allowed_file_types'].blank?
      record.errors.add('details.max_number_of_files', "can't be blank") if details['max_number_of_files'].blank?
      return unless details['max_number_of_files'].present? && details['max_number_of_files'].to_i.zero?

      record.errors.add('details.max_number_of_files', 'should be greater than 0')
    end
  end
end
