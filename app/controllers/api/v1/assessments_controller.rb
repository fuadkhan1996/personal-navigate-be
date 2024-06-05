# frozen_string_literal: true

module Api
  module V1
    class AssessmentsController < ApplicationController
      before_action :set_assessment, only: %i[show update]

      def show
        render json: ::AssessmentBlueprint.render(@assessment), status: :ok
      end

      def create
        @assessment = Assessment.new(create_assessment_params)
        if @assessment.save
          render json: { id: @assessment.id, message: 'Assessment Created Successfully.' }, status: :created
        else
          unprocessable_entity(@action.errors.messages)
        end
      end

      def update
        if @assessment.update(update_assessment_params)
          render json: ::AssessmentBlueprint.render(@assessment), status: :ok
        else
          unprocessable_entity(@action.errors.messages)
        end
      end

      private

      def create_assessment_params
        params.require(:assessment).permit(
          :title,
          :account_id,
          { form_data: {} }
        ).merge(
          {
            dc_company_id: current_employee.company.id,
            dc_company_employee_id: current_employee.company_employee_id,
            nav_questionnaire_id: Questionnaire.first.try(:id)
          }
        )
      end

      def update_assessment_params
        params.require(:assessment).permit(
          :title,
          { form_data: {} }
        )
      end

      def set_assessment
        @assessment = Assessment.find_by(
          dc_company_id: current_employee.company.id,
          id: params[:id]
        )
      end
    end
  end
end
