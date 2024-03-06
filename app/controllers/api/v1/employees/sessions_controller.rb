# frozen_string_literal: true

module Api
  module V1
    module Employees
      class SessionsController < ApplicationController
        def create
          response = Dc::Employee.authenticate(sign_in_params[:email], sign_in_params[:password])

          if response[:error].blank?
            render json: response, status: :ok
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
