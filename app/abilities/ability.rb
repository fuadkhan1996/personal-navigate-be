# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    BaseAbility.subclasses.each do |klass|
      merge klass.new(user)
    end
  end
end
