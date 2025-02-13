# frozen_string_literal: true

class AssociatedActivityAbility < BaseAbility
  def initialize(user)
    super()

    if user.company_type_name == 'Account'
      can :read, AssociatedActivity, { assessment: { account_id: user.dc_company_id } }
      can :read, AssociatedActivity, company_id: user.dc_company_id
    elsif user.employee_type == 'Admin/Owner'
      can :manage, AssociatedActivity, { activity: { dc_company_id: user.dc_company_id } }
    elsif user.employee_type == 'Agent'
      can :read, AssociatedActivity, { assessment: { account_id: user.assigned_company_ids } }
      can :read, AssociatedActivity, company_id: user.assigned_company_ids
    end
  end
end
