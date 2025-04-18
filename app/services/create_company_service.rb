# frozen_string_literal: true

class CreateCompanyService < ApplicationService
  attr_reader :params

  def initialize(params:)
    super()
    @params = params
  end

  def call
    @company = Dc::Company.new(create_params)
    if @company.save
      @company_employee = @company.company_employees.first
      @company_employee&.invite!(current_company_employee) if @company_employee.present?
    end

    @company
  end

  private

  def company_attributes
    return @company_attributes if @company_attributes.present?

    @company_attributes = params.except(:employee_attributes, :company_type_name)
    @company_attributes = @company_attributes.merge({ comp_type_id: company_type.try(:id) })
  end

  def employee_attributes
    return {} if params[:employee_attributes].blank?

    attributes = params[:employee_attributes].try(:first) || {}
    attributes[:email] = attributes[:email].try(:downcase) if attributes[:email].present?
    attributes
  end

  def create_params
    attrs = company_attributes
    attrs = merge_employee_attributes(attrs)
    attrs.merge(partner_company_connections_attributes: [{ dc_company_id: current_company.id }])
  end

  def merge_employee_attributes(attrs)
    return attrs if employee_attributes.blank?

    attrs.merge(company_employees_attributes: [
                  {
                    employee_type: 'Insured',
                    employee_attributes:
                  }
                ])
  end

  def company_type
    @company_type ||= Dc::CompanyType.find_by(name: params[:company_type_name])
  end
end
