# frozen_string_literal: true

module Api
  module V1
    class ActivitiesController < ApplicationController
      before_action :set_activity, only: %i[show]
      before_action :authorize_activity!, only: %i[show create]

      def index
        @activities = Activity.accessible_by(current_ability)
                              .includes(activity_actions: :action)
                              .order(created_at: :desc)

        render json: ::ActivityBlueprint.render(@activities, view: :normal), status: :ok
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
          activity_actions_attributes: activity_actions_params
        ).merge(
          dc_company_employee_id: current_employee.id,
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

      def set_activity
        @activity = Activity.accessible_by(current_ability).find_by(id: params[:id])
      end

      def authorize_activity!
        return authorize! :create, Activity if action_name == 'create'

        authorize! :read, @activity
      end
    end
  end
end
