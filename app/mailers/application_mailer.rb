# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@mydatacrest.com'
  layout 'mailer'
end
