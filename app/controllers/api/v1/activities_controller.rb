# frozen_string_literal: true

module Api
  module V1
    class ActivitiesController < ApplicationController
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
          dc_company_employee_id: current_employee.company_employee_id,
          dc_company_id: current_employee.dc_company_id
        )
      end

      def activity_actions_params
        [
          :title,
          :description,
          { details: {} },
          :order,
          :nav_action_id
        ]
      end
    end
  end
end
