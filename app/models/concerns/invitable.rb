# frozen_string_literal: true

module Invitable
  extend ActiveSupport::Concern

  attr_accessor :raw_invitation_token

  def invited_by=(inviter)
    super
    self.invited_by_type = 'CompanyEmployee'
  end

  def invited_by
    Dc::CompanyEmployee.find(invited_by_id)
  end

  def invite!(inviter)
    self.invited_by = inviter
    generate_invitation_token
    self.invitation_created_at ||= Time.current
    self.invitation_sent_at = Time.current
    self.invitations_count = invitations_count.to_i + 1
    save!
    CompanyEmployeeMailer.invite(id:).deliver_later
  end

  def generate_invitation_token
    raw_invitation_token, invitation_token = TokenGenerator.new.generate(:invitation_token)
    self.raw_invitation_token = raw_invitation_token
    self.invitation_token = invitation_token
  end
end
