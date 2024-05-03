# frozen_string_literal: true

class Action < ApplicationRecord
  self.table_name = :nav_actions

  belongs_to :action_type, foreign_key: 'nav_action_type_id', inverse_of: :actions
  has_many_attached :supporting_documents

  before_validation :change_max_number_of_files_to_integer
  validates :title, :description, presence: true
  validates :title, uniqueness: { case_sensitive: false, scope: :dc_company_employee_id }
  validate :validate_details

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
