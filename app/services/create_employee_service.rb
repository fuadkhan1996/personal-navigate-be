# frozen_string_literal: true

class CreateEmployeeService < ApplicationService
  attr_accessor :params

  def initialize(params:)
    super()
    @params = params
  end

  def call
    @company_employee = Dc::CompanyEmployee.new(create_params)
    if block_given?
      yield(@company_employee)
    else
      @company_employee.save
    end

    @company_employee
  end

  def call_with_invitation
    call do |company_employee|
      company_employee.invite!(current_user)
    end
  rescue ActiveRecord::RecordInvalid => e
    e.record
  end

  private

  def create_params
    company_employee_attributes.merge(employee_params)
  end

  def company_employee_attributes
    @company_employee_attributes ||= params.except(:employee_attributes)
  end

  def employee_attributes
    @employee_attributes ||= params[:employee_attributes].tap do |employee_attributes|
      employee_attributes[:email]&.downcase!
    end
  end

  def employee_params
    { employee_attributes: employee_attributes || {} }
  end

  def company
    @company ||= Dc::Company.find_by(id: params[:dc_company_id])
  end
end
