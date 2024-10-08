# frozen_string_literal: true

class CreateEmployeeService < ApplicationService
  attr_accessor :params

  def initialize(params:)
    super()
    @params = params
  end

  def call
    @company_employee = Dc::CompanyEmployee.new(create_params)
    @company_employee.invite!(current_company_employee) if @company_employee.save

    @company_employee
  end

  private

  def create_params
    company_employee_attributes.merge(employee_params)
  end

  def company_employee_attributes
    @company_employee_attributes ||= params.except(:employee_attributes)
  end

  def employee_attributes
    @employee_attributes ||= params[:employee_attributes]
  end

  def employee_params
    @employee = Dc::Employee.find_by(email: employee_attributes[:email])
    return { dc_employee_id: @employee.id } if @employee.present?

    { employee_attributes: employee_attributes || {} }
  end

  def company
    @company ||= Dc::Company.find_by(id: params[:dc_company_id])
  end
end
