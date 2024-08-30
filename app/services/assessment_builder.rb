# frozen_string_literal: true

class AssessmentBuilder
  attr_reader :params

  def initialize(params:)
    @params = params
  end

  def self.create(params:)
    new(params: params).create
  end

  def create
    ActiveRecord::Base.transaction do
      assessment = Assessment.new(params)

    end
  rescue Activerecord::RecordInvalid => e
    raise e
  end
end
