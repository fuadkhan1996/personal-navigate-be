# frozen_string_literal: true

class AssessmentAbility < BaseAbility
  def initialize(user)
    super()

    if user.company_type_name == 'Account'
      can :manage, Assessment, { account_id: user.dc_company_id }
    elsif user.employee_type == 'Agent'
      can :manage, Assessment, { dc_company_id: user.assigned_company_ids }
    else
      can :manage, Assessment, { dc_company_id: user.dc_company_id }
    end
  end
end
