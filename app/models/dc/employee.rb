# frozen_string_literal: true

module Dc
  class Employee < ApplicationRecord
    include UuidGenerator
    include Authable

    self.table_name = :dc_employees

    attr_accessor :password,
                  :current_password, # Only use to update password
                  :should_validate_name_presence

    has_many :company_employees,
             dependent: :restrict_with_exception,
             class_name: 'Dc::CompanyEmployee',
             foreign_key: :dc_employee_id,
             inverse_of: :employee

    has_many :companies, through: :company_employees

    validates :first_name, :last_name, presence: true, if: :should_validate_name_presence?
    validates :password, :password_confirmation, presence: true, if: :password_required?
    validates :email, uniqueness: { case_sensitive: false }
    validates :email, format: {
      with: URI::MailTo::EMAIL_REGEXP,
      message: I18n.t('activerecord.errors.models.employee.attributes.email.invalid_format')
    }
    validates :password, confirmation: true, if: :password_required?
    validates :password, format: {
      with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{8,}\z/,
      message: I18n.t('activerecord.errors.models.employee.attributes.password.invalid_format')
    }, if: :password_required?

    before_validation :downcase_email, if: :will_save_change_to_email?
    after_update :update_email_in_cognito, if: :saved_change_to_email?

    def fullname
      [first_name.presence || '', last_name.presence || ''].join(' ').strip
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

    def cognito_username
      @cognito_username ||= Cognito::Base.admin_get_user(user_object: { email: }).try(:username)
    end

    private

    def password_required?
      password.present? || password_confirmation.present?
    end

    def should_validate_name_presence?
      !!should_validate_name_presence
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

    def downcase_email
      self.email = email.try(:downcase)
    end
  end
end
