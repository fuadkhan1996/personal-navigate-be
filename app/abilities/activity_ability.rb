# frozen_string_literal: true

class ActivityAbility < BaseAbility
  def initialize(user)
    super()

    if user.company_type_name == 'Account'
      can :read, Activity, { assessments: { account_id: user.dc_company_id } }
    elsif user.employee_type == 'Agent'
      can :read, Activity, { assessments: { account_id: user.assigned_company_ids } }
    else
      can :manage, Activity, { dc_company_id: user.dc_company_id }
    end
  end
end
