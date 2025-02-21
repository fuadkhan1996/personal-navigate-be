# frozen_string_literal: true

class AssignedCompanyEmployeeMailer < ApplicationMailer
  def notify_assignment(company_employee:, assigned_company:)
    @company_employee = company_employee
    @company = assigned_company
    mail(to: @company_employee.email, subject: "Assigned to #{@company.title}")
  end
end
