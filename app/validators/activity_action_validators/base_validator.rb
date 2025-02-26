# frozen_string_literal: true

module ActivityActionValidators
  class BaseValidator < ActiveModel::Validator
    def validate(record)
      raise NotImplementedError, 'Subclasses must implement the `validate` method'
    end
  end
end
