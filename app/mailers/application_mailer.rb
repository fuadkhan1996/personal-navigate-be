# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # suppress those lovely Out Of Office auto responses
  default 'X-Auto-Response-Suppress' => 'All'

  default from: proc { noreply_email }, charset: 'UTF-8'
  layout 'mailer'

  helper_method :host

  private

  def host
    @host ||= Rails.application.config.action_mailer.default_url_options[:host]
  end

  def noreply_email
    'DataCrest <no-reply@mydatacrest.com>'
  end
end
