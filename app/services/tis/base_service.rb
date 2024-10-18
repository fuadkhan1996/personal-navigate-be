# frozen_string_literal: true

module Tis
  class BaseService < ApplicationService
    BASE_URL = 'https://ix.ezsurveyform.com/tec102/576/ix'
    CONTENT_TYPE = 'text/xml'

    attr_reader :order_id

    def initialize(order_id:)
      super()
      @order_id = order_id
      @url = URI(BASE_URL)
    end

    def fetch_data
      response = send_request
      parse_response(response.read_body)
    end

    protected

    def parse_response(response_body)
      raise NotImplementedError, "This #{self.class} cannot respond to 'parse_response'"
    end

    def soap_action
      raise NotImplementedError, "This #{self.class} cannot respond to 'soap_action'"
    end

    def build_request_body
      raise NotImplementedError, "This #{self.class} cannot respond to 'build_request_body'"
    end

    private

    def send_request
      https = Net::HTTP.new(@url.host, @url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(@url)
      request['Content-Type'] = CONTENT_TYPE
      request['SOAPAction'] = soap_action
      request['Authorization'] = authorization_header
      request.body = build_request_body(order_id:)

      https.request(request)
    end

    def authorization_header
      credentials = "#{username}:#{password}"
      "Basic #{Base64.strict_encode64(credentials)}"
    end

    def username
      Rails.application.credentials[:tis_username]
    end

    def password
      Rails.application.credentials[:tis_password]
    end
  end
end
