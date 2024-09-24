# frozen_string_literal: true

class CompanyEmployeeMailer < ApplicationMailer
  def invite(id:, raw_invitation_token:)
    @company_employee = Dc::CompanyEmployee.find(id)
    @company = @company_employee.company
    @raw_invitation_token = raw_invitation_token
    mail(to: @company_employee.email, subject: "Invitation to join #{@company.title}")
  end
end
