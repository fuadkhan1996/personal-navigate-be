# frozen_string_literal: true

class Action < ApplicationRecord
  self.table_name = :nav_actions

  has_many_attached :supporting_documents
  has_many :questionnaire_actions,
           dependent: :restrict_with_exception,
           class_name: 'Questionnaire::Action',
           foreign_key: :nav_action_id,
           inverse_of: :action

  has_many :questionnaires, through: :questionnaire_actions
  has_many :activity_actions,
           dependent: :restrict_with_exception,
           class_name: 'Activity::Action',
           foreign_key: :nav_action_id,
           inverse_of: :action

  validates :title, :description, presence: true

  private

  def change_max_number_of_files_to_integer
    return if details['max_number_of_files'].blank?

    details['max_number_of_files'] = details['max_number_of_files'].to_i
  end

  def validate_details
    errors.add(:'details[allowed_file_types]', "can't be blank") if details['allowed_file_types'].blank?
    errors.add(:'details[max_number_of_files]', "can't be blank") if details['max_number_of_files'].blank?
  end
end
