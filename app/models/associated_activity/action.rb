# frozen_string_literal: true

class AssociatedActivity
  class Action < ApplicationRecord
    self.table_name = :nav_assessment_action_results

    include SoftDeletable

    FILE_UPLOAD_REQUIRED_KEYS = %w[active_storage_blob_id key filename size content_type].freeze

    belongs_to :associated_activity, inverse_of: :associated_activity_actions
    belongs_to :activity_action,
               class_name: '::Activity::Action',
               foreign_key: :nav_activity_action_id,
               inverse_of: :associated_activity_actions

    has_one :action, through: :activity_action
    has_one :activity, through: :associated_activity

    validate :result_data_structure, on: :update, if: :will_save_change_to_result_data?
    validate :result_data_format, on: :update, if: :will_save_change_to_result_data?
    validate :activity_action_details_max_files, on: :update, if: :will_save_change_to_result_data?
    validate :activity_action_details_file_types, on: :update, if: :will_save_change_to_result_data?

    before_update :set_completed_at, unless: :deleted?

    delegate :action_kind, :file_upload?, to: :action
    delegate :details, :title, :description, to: :activity_action, prefix: true
    delegate :title, :description, :details, to: :activity_action

    def activity_action_id
      nav_activity_action_id
    end

    def assessment_id
      nav_assessment_id
    end

    def status
      completed? ? 'Complete' : 'Incomplete'
    end

    def complete!
      return if completed?

      update!(completed_at: DateTime.current)
    end

    def completed?
      completed_at.present?
    end

    private

    def set_completed_at
      return unless will_save_change_to_result_data?

      self.completed_at = result_data.present? ? Time.current : nil
    end

    def result_data_structure
      return if result_data.is_a?(Hash) && result_data['data'].is_a?(Array) && result_data['data'].size.positive?

      errors.add(:result_data, 'must be a hash with a :data key containing an array')
    end

    def result_data_format
      return if errors[:result_data].any?
      return unless action_kind == 'file_upload'
      return if valid_result_data_format?

      errors.add('result_data.data',
                 "each item in :data must contain only these keys: #{FILE_UPLOAD_REQUIRED_KEYS.join(', ')}")
    end

    def valid_result_data_format?
      result_data['data'].all? do |data|
        data.is_a?(Hash) && data.keys.sort == FILE_UPLOAD_REQUIRED_KEYS.sort
      end
    end

    def activity_action_details_max_files
      return if errors[:result_data].any?
      return unless action_kind == 'file_upload'
      return if activity_action_details.blank?
      return if result_data['data'].size <= activity_action_details['max_number_of_files']

      errors.add('result_data.data', "max files allowed are #{activity_action_details['max_number_of_files']}")
    end

    def activity_action_details_file_types
      return if errors[:result_data].any?
      return unless action_kind == 'file_upload'
      return if activity_action_details.blank?

      allowed_types = allowed_file_types_from_details
      return if allowed_types.empty? || valid_file_types?(allowed_types)

      errors.add('result_data.data', "file types allowed are #{allowed_types.join(', ')}")
    end

    def allowed_file_types_from_details
      return activity_action_details['allowed_file_types'] if activity_action_details['allowed_file_types'].is_a?(Array)

      (activity_action_details['allowed_file_types'] || '').split(',').map(&:strip)
    end

    def valid_file_types?(allowed_types)
      content_types = result_data['data'].pluck('content_type')
      content_types.all? { |type| allowed_types.include?(type) }
    end
  end
end
