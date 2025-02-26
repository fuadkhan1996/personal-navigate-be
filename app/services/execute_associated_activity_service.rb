# frozen_string_literal: true

class ExecuteAssociatedActivityService < ApplicationService
  attr_reader :associated_activity

  def initialize(associated_activity)
    super()
    @associated_activity = associated_activity
  end

  def call
    associated_activity_actions.each do |associated_activity_action|
      next if associated_activity_action.completed?
      next if associated_activity_action.file_upload?

      AssociatedActivity::ActionMailer.with(associated_activity_action:).alert_notification.deliver_later
    end

    associated_activity.complete!
  end

  private

  def associated_activity_actions
    @associated_activity_actions ||= associated_activity.associated_activity_actions.includes(activity_action: :action)
  end
end
