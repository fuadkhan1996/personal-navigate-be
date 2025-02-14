# frozen_string_literal: true

class UpdateAssociatedActivityActionService < ApplicationService
  attr_accessor :associated_activity_action, :params

  def initialize(associated_activity_action:, params:)
    super()
    @params = params
    @associated_activity_action = associated_activity_action
  end

  def self.call(associated_activity_action:, params:)
    new(associated_activity_action:, params:).call
  end

  def call
    validate_result_data_structure
    validate_result_data_items_format
    return associated_activity_action if associated_activity_action.errors.any?

    associated_activity_action.update(associated_activity_params)

    # Attempt to mark the associated activity as complete
    associated_activity&.complete!
    # send_notification_if_complete
    associated_activity_action
  end

  private

  def associated_activity_params
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

    associated_activity_action.errors.add(:result_data, 'must be a hash with a :data key containing an array')
  end

  def validate_result_data_items_format
    return unless action_kind == 'file_upload'
    return if result_data[:data].all? { |item| item.is_a?(Hash) && item.keys == ['key'] }

    associated_activity_action.errors.add(:result_data,
                                          'each item in :data must be a hash with only the :key attribute')
  end

  def send_notification_if_complete
    return if associated_activity_action.errors.any?
    return unless associated_activity&.completed?

    Assessment::ActionResultMailer.notify_update(action_result_id: associated_activity_action.id).deliver_later
  end

  def result_data
    params[:result_data]
  end

  def action_kind
    associated_activity_action.action_kind
  end

  def associated_activity
    @associated_activity ||= associated_activity_action.associated_activity
  end
end
