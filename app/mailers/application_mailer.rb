# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@mydatacrest.com'
  layout 'mailer'

  helper_method :host

  private

  def host
    @host ||= Rails.application.config.action_mailer.default_url_options[:host]
  end
end
