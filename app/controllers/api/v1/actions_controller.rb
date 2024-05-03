# frozen_string_literal: true

module Api
  module V1
    class ActionsController < ApplicationController
      def create
        @action = Action.new(action_create_params)
        if @action.save
          render json: { message: 'Action Created Successfully.' }, status: :created
        else
          unprocessable_entity(@action.errors.messages)
        end
      end

      private

      def action_type
        @action_type ||= ActionType.find_by!(action_kind: params[:action_payload][:action_kind])
      end

      def action_create_params
        params.require(:action_payload).permit(
          :title,
          :description,
          :supporting_documents,
          details: details_params
        ).merge({
                  nav_action_type_id: action_type.id,
                  dc_company_employee_id: current_employee.company_employee_id,
                  dc_company_id: current_employee.dc_company_id
                })
      end

      def details_params
        case action_type.action_kind
        when 'file_upload'
          %i[allowed_file_types max_number_of_files]
        else
          {}
        end
      end
    end
  end
end
