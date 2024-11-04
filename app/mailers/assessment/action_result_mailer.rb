# frozen_string_literal: true

class Assessment
  class ActionResultMailer < ApplicationMailer
    def notify_update(action_result_id:)
      @action_result = Assessment::ActionResult.find_by(id: action_result_id)
      @assessment = @action_result.assessment
      @company_employee = @assessment.company_employee
      @account = @assessment.account
      @company = @company_employee.company
      @activity = @action_result.associated_activity
      mail(to: @company_employee.email, subject: "Updates Available: Assessment #{@assessment.title}")
    end
  end
end
