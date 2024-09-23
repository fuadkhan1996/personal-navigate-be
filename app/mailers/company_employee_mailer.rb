# frozen_string_literal: true

class CompanyEmployeeMailer < ApplicationMailer
  def invite(id:)
    @company_employee = Dc::CompanyEmployee.find(id)
    @company = @company_employee.company
    mail(to: @company_employee.email, subject: "Invitation to join #{@company.title}")
  end
end
