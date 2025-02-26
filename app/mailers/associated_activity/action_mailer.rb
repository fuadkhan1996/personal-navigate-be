# frozen_string_literal: true

class AssociatedActivity
  class ActionMailer < ApplicationMailer
    attr_reader :associated_activity_action

    after_deliver :mark_as_complete

    def alert_notification
      @associated_activity_action = params[:associated_activity_action]
      @associated_activity = @associated_activity_action.associated_activity
      @assessment = @associated_activity.assessment
      @message = @associated_activity_action.description.presence || @associated_activity_action.title
      @recipients = extract_recipients
      @recipients.each do |recipient|
        @company_employee = recipient
        mail(to: recipient.email, subject: @associated_activity_action.title)
      end
    end

    private

    def extract_recipients
      recipient_ids = @associated_activity_action.details['recipients'] || []
      Dc::CompanyEmployee.where(id: recipient_ids)
    end

    def mark_as_complete
      return if @associated_activity_action.blank?

      @associated_activity_action.complete!
      @associated_activity_action.associated_activity.complete!
    end
  end
end
