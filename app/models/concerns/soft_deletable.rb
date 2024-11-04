# frozen_string_literal: true

module SoftDeletable
  extend ActiveSupport::Concern

  included do
    # default_scope { where("#{table_name}.deleted_at IS NULL") }

    # scope :with_deleted, -> { unscope(where: :deleted_at) }
    scope :deleted, -> { where("#{table_name}.deleted_at IS NOT NULL") }
    scope :active, -> { where("#{table_name}.deleted_at IS NULL") }
  end

  # Soft delete the record by setting deleted_at
  def soft_delete
    update(deleted_at: Time.current)
  end

  # Restore a soft-deleted record
  def restore
    update(deleted_at: nil)
  end

  # Check if the record is soft-deleted
  def deleted?
    deleted_at.present?
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # Soft delete the records by setting deleted_at
    def soft_delete
      all.update(deleted_at: Time.current)
    end

    # Restore a soft-deleted records
    def restore
      all.update(deleted_at: nil)
    end
  end
end
