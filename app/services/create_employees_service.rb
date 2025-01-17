# frozen_string_literal: true

class CreateEmployeesService < ApplicationService
  attr_accessor :params

  ResponseStruct = Struct.new(:status, :message, :errors, keyword_init: true)

  def initialize(params:)
    super()
    @params = params
  end

  def call
    invited_employees = process_invitations
    send_invitations(invited_employees)

    ResponseStruct.new(status: :success, message: "#{invited_employees.count} invitations sent successfully.")
  rescue ActiveRecord::RecordInvalid => e
    ResponseStruct.new(status: :failed, errors: e.record.errors)
  end

  private

  def process_invitations
    invited_employees = []

    ActiveRecord::Base.transaction do
      email_addresses.each do |email|
        invited_employees << create_and_validate_employee(email)
      end
    end

    invited_employees
  end

  def create_and_validate_employee(email)
    invited_employee = create_employee(email)
    return invited_employee if invited_employee.persisted?

    raise ActiveRecord::RecordInvalid.new(invited_employee), "Validation failed for email: #{invited_employee.email}"
  end

  def send_invitations(invited_employees)
    invited_employees.each do |employee|
      employee.invite!(current_user)
    end
  end

  def create_employee(email)
    CreateEmployeeService.new(params: create_params(email)).call
  end

  def create_params(email)
    {
      employee_type: params[:employee_type],
      dc_company_id: params[:dc_company_id],
      employee_attributes: { email: }
    }
  end

  def email_addresses
    params_emails = (params[:email_addresses] || []).compact_blank
    params_emails - existing_employee_emails
  end

  def existing_employee_emails
    @existing_employee_emails ||= company.employees.pluck(:email)
  end

  def company
    @company ||= Dc::Company.find_by(id: params[:dc_company_id])
  end
end
