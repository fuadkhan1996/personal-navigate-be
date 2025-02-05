# frozen_string_literal: true

module Api
  module V1
    class AssociatedActivitiesController < ApplicationController
      before_action :set_company
      before_action :validate_company!

      def index
        @associated_activities = @company.activity_connections.includes(
          :activity,
          { associated_activity_actions: :activity_action }
        )

        render json: AssociatedActivityBlueprint.render(@associated_activities), status: :ok
      end

      def create
        @associated_activity = AssociatedActivity.new(create_params.merge(company_id: @company.id))
        if @associated_activity.save
          render json: AssociatedActivityBlueprint.render(@associated_activity), status: :created
        else
          unprocessable_entity(@associated_activity.errors.messages)
        end
      end

      private

      def create_params
        params.permit(:company_id, associated_activity: %i[activity_id]).require(:associated_activity)
      end

      def set_company
        @company = current_company.linked_companies.find_by(id: params[:company_id])
      end

      def validate_company!
        return if @company.present?

        raise ActiveRecord::RecordNotFound, "Company could not be found with ID: #{params[:company_id]}."
      end
    end
  end
end
