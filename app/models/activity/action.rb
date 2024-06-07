# frozen_string_literal: true

class Activity
  class Action < ApplicationRecord
    self.table_name = :nav_activity_actions

    attr_accessor :document_keys, :linked_action_kind

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
    before_validation :set_action_id, if: :linked_action_kind
    after_save :attach_supporting_documents

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

    def set_action_id
      self.nav_action_id = ::Action.find_by(action_kind: linked_action_kind).try(:id)
    end

    def attach_supporting_documents
      return if document_keys.blank?

      current_file_keys = supporting_documents.map(&:blob).map(&:key)
      document_keys.each do |key|
        next if current_file_keys.include?(key)

        blob = ActiveStorage::Blob.find_by(key:)
        supporting_documents.attach(blob) if blob
      end
    end
  end
end
