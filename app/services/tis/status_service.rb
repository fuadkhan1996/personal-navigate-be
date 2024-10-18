# frozen_string_literal: true

module Tis
  class StatusService < BaseService
    private

    def soap_action
      'http://ix.ezsurveyform.com/ProcessRequest#status'
    end

    def build_request_body(order_id:)
      <<~XML
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tns="http://ix.ezsurveyform.com/ProcessRequest">
           <soapenv:Body>
              <tns:status>
                 <req>#{order_id}</req>
              </tns:status>
           </soapenv:Body>
        </soapenv:Envelope>
      XML
    end

    def parse_response(response)
      doc = Nokogiri::XML(response)
      namespace = { 'ns' => 'http://ix.ezsurveyform.com/ProcessRequest' }
      doc.at_xpath('//ns:statusResponse/ns:s-gensym3', namespace)&.text
    end
  end
end
