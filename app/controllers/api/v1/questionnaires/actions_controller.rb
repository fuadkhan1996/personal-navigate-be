# frozen_string_literal: true

module Api
  module V1
    module Questionnaires
      class ActionsController < ApplicationController
        def index
          @actions = questionnaire.questionnaire_actions
                                  .joins(:action)
                                  .where(nav_actions: { dc_company_id: current_employee.dc_company_id })
                                  .order(updated_at: :desc)

          render json: Questionnaire::ActionSerializer.new(@actions).serializable_hash.to_json, status: :ok
        end

        def create
          @questionnaire_action = questionnaire.questionnaire_actions.new(questionnaire_action_create_params)
          if @questionnaire_action.save
            render json: { message: 'Action Attached Successfully.' }, status: :created
          else
            unprocessable_entity(@questionnaire_action.errors.messages)
          end
        end

        private

        def questionnaire
          @questionnaire ||= Questionnaire.find(params[:questionnaire_id])
        end

        def questionnaire_action_create_params
          params.require(:questionnaire_action).permit(:nav_action_id, :criteria).tap do |transformed_params|
            if transformed_params[:criteria].is_a?(String)
              transformed_params[:criteria] = begin
                JSON.parse(transformed_params[:criteria])
              rescue JSON::ParserError
                {}
              end
            end
          end.permit(:nav_action_id, criteria: criteria_params)
        end

        def criteria_params
          { conditions: %i[key operator value] }
        end
      end
    end
  end
end
