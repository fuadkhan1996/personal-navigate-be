# frozen_string_literal: true

module Tis
  class ReportService < BaseService
    private

    def soap_action
      'http://ix.ezsurveyform.com/ProcessRequest#report'
    end

    def build_request_body(order_id:)
      <<~XML
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tns="http://ix.ezsurveyform.com/ProcessRequest">
           <soapenv:Body>
              <tns:report>
                 <req>#{order_id}</req>
              </tns:report>
           </soapenv:Body>
        </soapenv:Envelope>
      XML
    end

    def parse_response(response)
      doc = parse_xml(response)
      data = parse_inner_xml(extract_content(doc))
      map_data(data)
    end

    def parse_xml(response)
      doc = Nokogiri::XML(response)
      doc.remove_namespaces!
      doc
    end

    def extract_content(doc)
      s_gensym3_element = doc.at_xpath('//s-gensym3')
      s_gensym3_element.content
    end

    def parse_inner_xml(s_gensym3_content)
      xml = "<root>#{CGI.unescapeHTML(s_gensym3_content)}</root>"
      Nokogiri::XML(xml).root.elements.each_with_object({}) do |element, hash|
        hash[element.name] = element.text
      end
    end

    def map_data(data)
      mapping.each_with_object({}) do |(key, config), result|
        next unless data.key?(key)

        mapped_key = config['mapped_to']
        value = data[key]
        result[mapped_key] = config['split'] ? value.split(config['split']) : value
      end
    end

    def mapping
      @mapping ||= Oj.load(File.read(mapping_file_path))
    end

    def mapping_file_path
      @mapping_file_path ||= File.join(Dir.pwd, 'msi_questionnaire_mapping.json')
    end
  end
end
