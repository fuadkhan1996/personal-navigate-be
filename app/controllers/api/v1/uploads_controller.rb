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

      def download
        blob = ActiveStorage::Blob.find_by(key: params[:key])
        raise ActiveRecord::RecordNotFound, "Blob with Key #{params[:key]} not found" if blob.blank?

        render json: { url: url_for(blob) }, status: :ok
      end

      private

      def upload_params
        params.permit(:file)
      end
    end
  end
end
