# frozen_string_literal: true

class AssociatedActivity < ApplicationRecord
  self.table_name = :nav_associated_activities

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

  before_create :set_associated_activity_actions

  private

  def set_associated_activity_actions
    activity.activity_actions.each do |activity_action|
      associated_activity_actions.new(activity_action:)
    end
  end
end
