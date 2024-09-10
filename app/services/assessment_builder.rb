# frozen_string_literal: true

class AssessmentBuilder
  attr_reader :params

  def initialize(params:)
    @params = params
  end

  def self.create(params:)
    new(params:).create
  end

  def create; end

  private

  def assessment_params; end
end
