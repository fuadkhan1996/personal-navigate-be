# frozen_string_literal: true

class AssociatedActivityBlueprint < ApplicationBlueprint
  identifier :id

  api_association :activity, blueprint: ActivityBlueprint
  api_association :associated_activity_actions, blueprint: Assessment::ActionResultBlueprint
  # api_association :assessment, blueprint: AssessmentBlueprint
end
