# frozen_string_literal: true

ResponseStruct = Struct.new(:status, :message, keyword_init: true)

module Tis
  class RequestHandlerService < ApplicationService
    def initialize
      super
      @processed_assessment_ids = []
    end

    def process_all_assessments
      ActiveRecord::Base.transaction do
        incomplete_assessments.each do |assessment|
          process_assessment(assessment)
        end
      end

      notify_company_employees
      ResponseStruct.new(status: 'success', message: 'Assessments processed successfully.')
    rescue StandardError => e
      Rails.logger.error("Error processing assessments: #{e.message}")
      ResponseStruct.new(status: 'failure', message: "Error processing assessments: #{e.message}")
    end

    private

    def process_assessment(assessment)
      status = fetch_status(assessment.tis_order_id)
      return if status == 'New'

      report = fetch_report(assessment.tis_order_id)
      assessment.update!(completed_at: DateTime.current, form_data: report)
      @processed_assessment_ids << assessment.id
    end

    def incomplete_assessments
      @incomplete_assessments ||= Assessment.where.not(tis_order_id: nil).incomplete
    end

    def fetch_status(order_id)
      status_service = StatusService.new(order_id:)
      status_service.fetch_data
    end

    def fetch_report(order_id)
      status_service = ReportService.new(order_id:)
      status_service.fetch_data
    end

    def notify_company_employees
      @processed_assessment_ids.each do |assessment_id|
        AssessmentMailer.notify_assessment_completion(assessment_id:).deliver_later
      end
    end
  end
end
