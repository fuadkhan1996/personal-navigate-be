# frozen_string_literal: true

module Dc
  class Employee < ApplicationRecord
    include UuidGenerator
    include Authable

    self.table_name = :dc_employees

    attr_accessor :password

    has_many :company_employees,
             dependent: :restrict_with_exception,
             class_name: 'Dc::CompanyEmployee',
             foreign_key: :dc_employee_id,
             inverse_of: :employee

    has_many :companies, through: :company_employees

    validates :password, :password_confirmation, presence: true, if: :password_required?
    validates :password, confirmation: true, if: :password_required?
    validates :password, format: {
      with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{8,}\z/,
      message: I18n.t('activerecord.errors.models.employee.attributes.password.invalid_format')
    }, if: :password_required?

    after_save :update_email_in_cognito, if: :saved_change_to_email?

    def fullname
      [first_name, last_name].join(' ')
    end

    private

    def password_required?
      password.present? || password_confirmation.present?
    end

    def update_email_in_cognito
      Cognito::Base.update_email(user_object: { email: }, access_token: current_access_token)
    end
  end
end
