# frozen_string_literal: true

module Api
  module V1
    class ActivitiesController < ApplicationController
      before_action :set_activity, only: %i[show]
      before_action :authorize_activity!, only: %i[show create]

      def index
        @activities = activities
        @activities = @activities.by_action_kind(params[:action_kind]) if params[:action_kind].present?
        render json: ::ActivityBlueprint.render(@activities.order(created_at: :desc), view: :normal), status: :ok
      end

      def show
        render json: ::ActivityBlueprint.render(@activity, view: :extended), status: :ok
      end

      def create
        @activity = Activity.new(activity_create_params)
        if @activity.save
          render json: { id: @activity.id, message: 'Activity Created Successfully.' }, status: :created
        else
          unprocessable_entity(@activity.errors.messages)
        end
      end

      private

      def activity_create_params
        params.require(:activity).permit(
          :title,
          :description,
          { trigger_ids: [] },
          { activity_actions_attributes: activity_actions_params }
        ).merge(
          dc_company_employee_id: current_company_employee.id,
          dc_company_id: current_company.id
        )
      end

      def activity_actions_params
        [
          :title,
          :description,
          { document_keys: [] },
          { details: {} },
          :order,
          :linked_action_kind
        ]
      end

      def activities
        Activity.accessible_by(current_ability).includes({ company: :company_type }, { company_employee: :employee })
      end

      def set_activity
        @activity = activities.find_by(id: params[:id])
      end

      def authorize_activity!
        return authorize! :create, Activity if action_name == 'create'

        authorize! :read, @activity
      end
    end
  end
end
