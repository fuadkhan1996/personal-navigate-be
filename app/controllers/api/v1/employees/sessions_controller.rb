# frozen_string_literal: true

module Api
  module V1
    module Employees
      class SessionsController < ApplicationController
        skip_before_action :authenticate_request!, only: :create

        def show
          render json: Dc::EmployeeSerializer.new(current_employee).serializable_hash.to_json, status: :ok
        end

        def create
          response = Dc::Employee.authenticate(sign_in_params[:email], sign_in_params[:password])
          if response[:access_token]
            render json: { data: response }, status: :created
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
