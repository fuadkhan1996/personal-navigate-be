# frozen_string_literal: true

module Api
  module V1
    class AssessmentsController < ApplicationController
      skip_before_action :set_current_company, only: %i[trigger_tis_api]
      skip_before_action :authenticate_request!, only: %i[trigger_tis_api]
      before_action :set_account, only: %i[index]
      before_action :set_assessment, only: %i[show update]
      before_action :authorize_assessment!, only: %i[show create update]

      def trigger_tis_api
        response = Tis::RequestHandlerService.new.process_all_assessments
        status = response.status == 'success' ? :ok : :unprocessable_entity
        render json: response.to_h, status:
      end

      def index
        @assessments = Assessment.accessible_by(current_ability).order(created_at: :desc)
        @assessments = @assessments.where(account_id: @account.id) if @account.present?
        render json: ::AssessmentBlueprint.render(@assessments.includes(:account)), status: :ok
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
          :tis_order_id,
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

      def set_account
        return if params[:account_id].blank?

        @account = current_company.linked_companies_by_company_type('Account').find_by(id: params[:account_id])
        raise ActiveRecord::RecordNotFound, "Account with ID #{params[:account_id]}" if @account.blank?
      end

      def authorize_assessment!
        return authorize! :create, Assessment if action_name == 'create'
        return authorize! :update, @assessment if action_name == 'update'

        authorize! :read, @assessment
      end
    end
  end
end
