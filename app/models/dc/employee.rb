# frozen_string_literal: true

module Dc
  class Employee < ApplicationRecord
    include UuidGenerator
    include Authable

    self.table_name = :dc_employees

    attr_accessor :password,
                  :current_password # Only use to update password

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

    after_update :update_email_in_cognito, if: :saved_change_to_email?

    def fullname
      [first_name, last_name].join(' ')
    end

    def update_password(password_params)
      self.current_password = password_params[:current_password]
      self.password = password_params[:password]
      self.password_confirmation = password_params[:password_confirmation]
      return false unless valid?

      response = update_cognito_password
      return true if response.status == 'success'

      errors.add(response.attribute, message: response.message)
      false
    end

    private

    def password_required?
      password.present? || password_confirmation.present?
    end

    def update_email_in_cognito
      previous_email, current_email = saved_change_to_email
      Cognito::Base.admin_update_email(user_object: { email: previous_email, proposed_email: current_email })
    end

    def update_cognito_password
      params = {
        current_password: current_employee.current_password,
        new_password: current_employee.password
      }
      Cognito::Base.update_password(**params)
    end
  end
end
