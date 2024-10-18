# frozen_string_literal: true

class AssessmentMailer < ApplicationMailer
  def notify_assessment_completion(assessment_id:)
    @assessment = Assessment.find_by(id: assessment_id)
    @company_employee = @assessment.company_employee
    @company = @company_employee.company
    mail(to: @company_employee.email, subject: "Your assessment #{@assessment.title} is ready for processing")
  end
end
