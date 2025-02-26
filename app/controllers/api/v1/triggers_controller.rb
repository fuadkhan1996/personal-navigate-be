# frozen_string_literal: true

module Api
  module V1
    class TriggersController < ApplicationController
      before_action :set_trigger, only: %i[show]

      def index
        render json: ::TriggerBlueprint.render(triggers.order(created_at: :desc)), status: :ok
      end

      def show
        render json: ::TriggerBlueprint.render(@trigger, view: :extended), status: :ok
      end

      def create
        trigger = current_company.triggers.new(create_params.merge(company_id: current_company.id,
                                                                   company_employee_id: current_company_employee.id))
        if trigger.save
          render json: ::TriggerBlueprint.render(trigger), status: :created
        else
          unprocessable_entity(trigger.errors.messages)
        end
      end

      private

      def create_params
        params.permit(trigger: [
                        :nav_questionnaire_id,
                        :title,
                        :description,
                        { criteria: {} }
                      ]).require(:trigger).tap do |transformed_params|
                        transformed_params[:criteria] = parse_and_permit_criteria(transformed_params[:criteria])
                      end
      end

      def parse_and_permit_criteria(criteria)
        if criteria.is_a?(String)
          begin
            parsed_criteria = JSON.parse(criteria)
            ActionController::Parameters.new(parsed_criteria)
                                        .permit(:conjunction, conditions: %i[key operator value])
          rescue JSON::ParserError
            {}
          end
        else
          criteria
        end
      end

      def questionnaire
        @questionnaire ||= Questionnaire.first
      end

      def set_trigger
        @trigger = triggers.find(params[:id])
      end

      def triggers
        @triggers ||= current_company.triggers.includes(:questionnaire)
      end
    end
  end
end
