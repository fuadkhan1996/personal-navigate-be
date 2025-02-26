# frozen_string_literal: true

class Action < ApplicationRecord
  self.table_name = :nav_actions

  has_many :activity_actions,
           dependent: :restrict_with_exception,
           class_name: 'Activity::Action',
           foreign_key: :nav_action_id,
           inverse_of: :action

  has_many :activities, through: :activity_actions

  validates :title, :description, presence: true

  def file_upload?
    action_kind == 'file_upload'
  end

  def alert?
    action_kind == 'alert'
  end
end
