# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApplicationController
      def index
        @accounts = current_employee.company.linked_accounts
        render json: Dc::CompanySerializer.new(@accounts).serializable_hash.to_json, status: :ok
      end
    end
  end
end
