# frozen_string_literal: true

module Api
  module V1
    class AssociatedActivitiesController < ApplicationController
      before_action :set_company
      before_action :validate_company!
      before_action :set_assessment
      before_action :validate_assessment!
      before_action :set_associated_activity, only: %i[show update]
      before_action :validate_associated_activity!, only: %i[show update]

      def index
        render json: AssociatedActivityBlueprint.render(associated_activities.order_by_pinned), status: :ok
      end

      def show
        render json: AssociatedActivityBlueprint.render(@associated_activity), status: :ok
      end

      def create
        @associated_activity = AssociatedActivity.new(create_params.merge(company_id: @company.id))
        if @associated_activity.save
          render json: AssociatedActivityBlueprint.render(@associated_activity), status: :created
        else
          unprocessable_entity(@associated_activity.errors.messages)
        end
      end

      def update
        if @associated_activity.update(update_params)
          render json: AssociatedActivityBlueprint.render(@associated_activity), status: :ok
        else
          unprocessable_entity(@associated_activity.errors.messages)
        end
      end

      private

      def create_params
        params.permit(:company_id, associated_activity: %i[activity_id]).require(:associated_activity)
      end

      def update_params
        params.permit(:id, associated_activity: %i[pinned]).require(:associated_activity)
      end

      def set_company
        @company = current_company.linked_companies.find_by(id: params[:company_id]) if params[:company_id].present?
        @company ||= current_company if current_company.account?
      end

      def set_assessment
        return if params[:assessment_id].blank?

        @assessment = Assessment.accessible_by(current_ability).find_by(id: params[:assessment_id])
      end

      def associated_activities
        return @associated_activities if @associated_activities.present?

        scope = if @assessment.present?
                  @assessment.associated_activities
                elsif @company.present?
                  @company.all_associated_activities
                else
                  AssociatedActivity.accessible_by(current_ability)
                end

        @associated_activities = scope.includes(
          :activity,
          { associated_activity_actions: :activity_action }
        )
      end

      def set_associated_activity
        @associated_activity = associated_activities.find_by(id: params[:id])
      end

      def primary_company_employee
        @primary_company_employee ||= @company&.primary_company_employee
      end

      def validate_company!
        return if params[:company_id].blank?
        return if @company.present?

        raise ActiveRecord::RecordNotFound, "Company could not be found with ID: #{params[:company_id]}."
      end

      def validate_assessment!
        return if params[:assessment].blank?
        return if @assessment.present?

        raise ActiveRecord::RecordNotFound, "Assessment could not be found with ID: #{params[:assessment_id]}."
      end

      def validate_associated_activity!
        return if @associated_activity.present?

        raise ActiveRecord::RecordNotFound, "Associated Activity could not be found with ID: #{params[:id]}."
      end
    end
  end
end
