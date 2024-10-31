# frozen_string_literal: true

class CreateCompanyService < ApplicationService
  attr_reader :params

  def initialize(params:)
    super()
    @params = params
  end

  def call
    @company = Dc::Company.new(create_params)
    ActiveRecord::Base.transaction do
      if account_exist?
        @company.errors.add(:base, 'already exist.')
      elsif @company.save
        @company_employee = @company.company_employees.first
      end

      raise ActiveRecord::Rollback if @company.errors.any?
    end

    @company_employee&.invite!(current_company_employee) if @company.persisted?
    @company
  end

  private

  def company_attributes
    return @company_attributes if @company_attributes.present?

    @company_attributes = params.except(:employee_attributes, :company_type_name)
    @company_attributes = @company_attributes.merge({ comp_type_id: company_type.try(:id) })
  end

  def employee_attributes
    attributes = params[:employee_attributes].try(:first) || {}
    attributes[:email] = attributes[:email].try(:downcase) if attributes[:email].present?
    attributes
  end

  def account_exist?
    email = employee_attributes[:email]
    current_company.linked_companies.joins(:employees, :company_type).where(dc_company_types: { name: 'Account' },
                                                                            dc_employees: { email: }).present?
  end

  def create_params
    attrs = company_attributes
    attrs = merge_employee_attributes(attrs)
    attrs.merge(partner_company_connections_attributes: [{ dc_company_id: current_company.id }])
  end

  def merge_employee_attributes(attrs)
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
