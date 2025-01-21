# frozen_string_literal: true

module Api
  module V1
    module Questionnaires
      class TriggersController < ApplicationController
        def index
          @triggers = questionnaire.active_activity_triggers.includes(:questionnaire, :activity)
                                   .for_company(current_company.id).order(created_at: :desc)

          render json: ::Activity::TriggerBlueprint.render(@triggers, view: :extended), status: :ok
        end

        private

        def questionnaire
          @questionnaire ||= Questionnaire.first
        end
      end
    end
  end
end
