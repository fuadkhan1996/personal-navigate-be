# frozen_string_literal: true

module Api
  module V1
    class AssessmentsController < ApplicationController
      before_action :set_assessment, only: %i[show update]
      before_action :authorize_assessment!, only: %i[show create update]

      def index
        @assessments = Assessment.accessible_by(current_ability).order(created_at: :desc)
        render json: ::AssessmentBlueprint.render(@assessments), status: :ok
      end

      def show
        render json: ::AssessmentBlueprint.render(@assessment, view: :extended), status: :ok
      end

      def create
        @assessment = Assessment.new(create_assessment_params)
        if @assessment.save
          render json: { id: @assessment.id, message: 'Assessment Created Successfully.' }, status: :created
        else
          unprocessable_entity(@assessment.errors.messages)
        end
      end

      def update
        if @assessment.update(update_assessment_params)
          render json: ::AssessmentBlueprint.render(@assessment), status: :ok
        else
          unprocessable_entity(@assessment.errors.messages)
        end
      end

      private

      def create_assessment_params
        params.require(:assessment).permit(
          :title,
          { form_data: {} }
        ).merge(default_create_assessment_attributes)
      end

      def default_create_assessment_attributes
        {
          dc_company_id: current_company.id,
          dc_company_employee_id: current_company_employee.id,
          nav_questionnaire_id: Questionnaire.first.try(:id)
        }
      end

      def update_assessment_params
        params.require(:assessment).permit(
          :title,
          :account_id,
          { form_data: {} }
        )
      end

      def set_assessment
        @assessment = Assessment.accessible_by(current_ability).find_by(id: params[:id])
      end

      def authorize_assessment!
        return authorize! :create, Assessment if action_name == 'create'
        return authorize! :update, @assessment if action_name == 'update'

        authorize! :read, @assessment
      end
    end
  end
end
