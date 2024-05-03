# frozen_string_literal: true

class ActionType < ApplicationRecord
  self.table_name = :nav_action_types

  has_many :actions, dependent: :restrict_with_exception
end
