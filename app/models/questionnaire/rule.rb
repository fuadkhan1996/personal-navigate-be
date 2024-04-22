# frozen_string_literal: true

class Questionnaire
  class Rule < ApplicationRecord
    self.table_name = :nav_questionnaire_rules

    belongs_to :nav_questionnnaire
    belongs_to :nav_rules
  end
end
