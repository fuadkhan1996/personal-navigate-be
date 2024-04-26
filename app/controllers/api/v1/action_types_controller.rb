# frozen_string_literal: true

module Api
  module V1
    class ActionTypesController < ApplicationController
      def index
        @action_types = ActionType.all
        render json: ActionTypeSerializer.new(@action_types).serializable_hash.to_json, status: :ok
      end
    end
  end
end
