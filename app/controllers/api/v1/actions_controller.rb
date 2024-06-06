# frozen_string_literal: true

module Api
  module V1
    class ActionsController < ApplicationController
      def index
        @actions = Action.all
        render json: ::ActionBlueprint.render(@actions), status: :ok
      end
    end
  end
end
