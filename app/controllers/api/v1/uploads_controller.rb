# frozen_string_literal: true

module Api
  module V1
    class UploadsController < ApplicationController
      def create
        blob = ActiveStorage::Blob.create_and_upload!(
          io: upload_params[:file],
          filename: upload_params[:file].original_filename,
          content_type: upload_params[:file].content_type
        )

        render json: { key: blob.key }, status: :created
      end

      private

      def upload_params
        params.permit(:file)
      end
    end
  end
end
