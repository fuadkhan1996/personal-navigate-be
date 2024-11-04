# frozen_string_literal: true

class Assessment
  class UpdateActionResultService < ApplicationService
    attr_accessor :action_result, :params

    def initialize(action_result:, params:)
      super()
      @params = params
      @action_result = action_result
    end

    def self.call(action_result:, params:)
      new(action_result:, params:).call
    end

    def call
      validate_result_data_structure
      validate_result_data_items_format
      return action_result if action_result.errors.any?

      action_result.update(action_result_params)
      send_notification_if_complete

      action_result
    end

    private

    def action_result_params
      { result_data: { data: result_data_params } }
    end

    def result_data_params
      file_keys = params[:result_data][:data].pluck(:key)
      blobs = ActiveStorage::Blob.where(key: file_keys)

      blobs.map do |blob|
        {
          active_storage_blob_id: blob.id,
          key: blob.key,
          filename: blob.filename,
          size: blob.byte_size,
          content_type: blob.content_type
        }
      end
    end

    def validate_result_data_structure
      return if result_data.is_a?(Hash) && result_data[:data].is_a?(Array)

      action_result.errors.add(:result_data, 'must be a hash with a :data key containing an array')
    end

    def validate_result_data_items_format
      return unless action_kind == 'file_upload'
      return if result_data[:data].all? { |item| item.is_a?(Hash) && item.keys == ['key'] }

      action_result.errors.add(:result_data, 'each item in :data must be a hash with only the :key attribute')
    end

    def send_notification_if_complete
      return if action_result.errors.any?
      return unless activity&.complete_for_assessment?(action_result.assessment_id)

      Assessment::ActionResultMailer.notify_update(action_result_id: action_result.id).deliver_later
    end

    def result_data
      params[:result_data]
    end

    def action_kind
      action_result.action_kind
    end

    def activity
      @activity ||= action_result.associated_activity
    end
  end
end
