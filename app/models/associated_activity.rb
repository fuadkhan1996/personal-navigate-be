# frozen_string_literal: true

class AssociatedActivity < ApplicationRecord
  self.table_name = :nav_associated_activities

  attr_accessor :skip_associated_activity_actions_creation

  belongs_to :activity, class_name: 'Activity', inverse_of: :activity_connections
  belongs_to :assessment, inverse_of: :associated_activities, optional: true
  belongs_to :company,
             class_name: 'Dc::Company',
             inverse_of: :activity_connections,
             optional: true

  has_many :associated_activity_actions,
           dependent: :destroy,
           class_name: 'AssociatedActivity::Action',
           inverse_of: :associated_activity

  has_many :activity_actions, through: :activity
  has_many :associated_activity_triggers,
           dependent: :destroy,
           class_name: 'AssociatedActivity::Trigger',
           inverse_of: :associated_activity

  before_create :set_associated_activity_actions, unless: :skip_associated_activity_actions_creation

  def completed?
    completed_at.present?
  end

  def complete!
    return unless all_associated_activity_actions_completed?

    update!(completed_at: DateTime.current)
  end

  def all_associated_activity_actions_completed?
    associated_activity_actions.all?(&:completed_at)
  end

  private

  def set_associated_activity_actions
    activity.activity_actions.each do |activity_action|
      associated_activity_actions.new(activity_action:)
    end
  end
end
