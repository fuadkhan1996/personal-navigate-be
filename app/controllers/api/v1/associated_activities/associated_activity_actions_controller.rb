# frozen_string_literal: true

module Api
  module V1
    module AssociatedActivities
      class AssociatedActivityActionsController < ApplicationController
        before_action :validate_associated_activity!
        before_action :set_associated_activity_action
        before_action :validate_associated_activity_action!

        def update
          UpdateAssociatedActivityActionService.call(
            associated_activity_action: @associated_activity_action,
            params: update_params.to_h.with_indifferent_access
          )

          if @associated_activity_action.errors.any?
            unprocessable_entity(@associated_activity_action.errors.messages)
          else
            render json: ::AssociatedActivity::ActionBlueprint.render(@associated_activity_action), status: :ok
          end
        end

        private

        def update_params
          params.require(:associated_activity_action).permit(result_data: {})
        end

        def associated_activity
          @associated_activity ||= AssociatedActivity.accessible_by(current_ability)
                                                     .find_by(id: params[:associated_activity_id])
        end

        def set_associated_activity_action
          @associated_activity_action = associated_activity.associated_activity_actions.find_by(id: params[:id])
        end

        def validate_associated_activity!
          return if associated_activity.present?

          raise ActiveRecord::RecordNotFound,
                "Associated Activity could not be found with ID: #{params[:associated_activity_id]}."
        end

        def validate_associated_activity_action!
          return if @associated_activity_action.present?

          raise ActiveRecord::RecordNotFound,
                "Associated Activity Action could not be found with ID: #{params[:id]}."
        end
      end
    end
  end
end
