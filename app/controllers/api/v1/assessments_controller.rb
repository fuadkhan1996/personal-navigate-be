# frozen_string_literal: true

module Api
  module V1
    class AssessmentsController < ApplicationController
      before_action :set_assessment, only: %i[show]

      def show
        render json: AssessmentSerializer.new(@assessment).serializable_hash.to_json, status: :ok
      end

      def create
        @assessment = Assessment.new(create_assessment_params)
        if @assessment.save
          render json: { id: @assessment.id, message: 'Assessment Created Successfully.' }, status: :created
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

      def set_assessment
        @assessment = Assessment.find_by(
          dc_company_id: current_employee.company.id,
          id: params[:id]
        )
      end
    end
  end
end
