# frozen_string_literal: true

module Api
  module V1
    module Employees
      class SessionsController < ApplicationController
        skip_before_action :authenticate_request!, only: :create

        def create
          employee = Dc::Employee.authenticate(sign_in_params[:email], sign_in_params[:password])
          if employee.is_a?(Dc::Employee)
            render json: { employee: employee.attributes }, status: :ok
          else
            invalid_credentials
          end
        end

        private

        def sign_in_params
          params.require(:employee).permit(:email, :password)
        end
      end
    end
  end
end
