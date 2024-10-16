# frozen_string_literal: true

module Invitable
  attr_accessor :raw_invitation_token

  def invited_by=(inviter)
    super
    self.invited_by_type = 'CompanyEmployee'
  end

  def invited_by
    Dc::CompanyEmployee.find(invited_by_id)
  end

  def invitation_accepted?
    invitation_accepted_at.present?
  end

  def invite!(inviter)
    self.invited_by = inviter
    generate_invitation_token
    self.invitation_created_at ||= Time.current
    self.invitation_sent_at = Time.current
    self.invitations_count = invitations_count.to_i + 1
    save!
    CompanyEmployeeMailer.invite(id:, raw_invitation_token:).deliver_later
  end

  def generate_invitation_token
    raw_invitation_token, invitation_token = TokenGenerator.new.generate(:invitation_token)
    self.raw_invitation_token = raw_invitation_token
    self.invitation_token = invitation_token
  end

  def valid_invitation?
    time = invitation_created_at || invitation_sent_at
    time && time.utc >= 7.days.ago
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def accept_invitation!
    self.invitation_accepted_at = Time.now.utc
    self.invitation_token = nil
    self.confirmed_at ||= invitation_accepted_at
    save!
  end

  module ClassMethods
    def find_by_invitation_token(token)
      decrpyted_token = TokenGenerator.new.digest(:invitation_token, token)
      return if decrpyted_token.blank?

      company_employee = find_by(invitation_token: decrpyted_token)
      return if company_employee.blank?

      if company_employee.invitation_token && company_employee.persisted? && company_employee.valid_invitation?
        company_employee
      end
    end
  end
end
