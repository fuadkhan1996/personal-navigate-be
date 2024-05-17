# frozen_string_literal: true

class Questionnaire
  class Action < ApplicationRecord
    self.table_name = :nav_questionnaire_actions

    belongs_to :questionnaire,
               class_name: '::Questionnaire',
               foreign_key: :nav_questionnaire_id,
               inverse_of: :questionnaire_actions

    belongs_to :action, class_name: '::Action', foreign_key: :nav_action_id, inverse_of: :questionnaire_actions

    validates :criteria, presence: true

    delegate :title, :description, to: :action, prefix: true

    def action_id
      nav_action_id
    end
  end
end
