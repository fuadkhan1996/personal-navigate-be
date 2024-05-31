# frozen_string_literal: true

class Activity
  class Action < ApplicationRecord
    self.table_name = :nav_activity_actions

    belongs_to :activity,
               class_name: '::Activity',
               foreign_key: :nav_activity_id,
               inverse_of: :activity_actions

    belongs_to :action, class_name: '::Action', foreign_key: :nav_action_id, inverse_of: :activity_actions
    has_many_attached :supporting_documents
    has_many :assessment_action_results,
             dependent: :restrict_with_exception,
             class_name: '::Assessment::ActionResult',
             foreign_key: :nav_activity_action_id,
             inverse_of: :activity_action

    before_validation :change_max_number_of_files_to_integer

    validates :title, presence: true
    validates :title, uniqueness: { case_sensitive: false, scope: :activity }
    validate :validate_details

    delegate :action_kind, to: :action, allow_nil: true
    delegate :title, :description, to: :action, prefix: true

    private

    def change_max_number_of_files_to_integer
      return unless action_kind == 'file_upload'
      return if details['max_number_of_files'].blank?

      details['max_number_of_files'] = details['max_number_of_files'].to_i
    end

    def validate_details
      errors.add(:'details.allowed_file_types', "can't be blank") if details['allowed_file_types'].blank?
      errors.add(:'details.max_number_of_files', "can't be blank") if details['max_number_of_files'].blank?
    end
  end
end
