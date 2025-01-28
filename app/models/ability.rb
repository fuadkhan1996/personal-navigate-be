# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(company_employee)
    if company_employee.company_type_name == 'Account'
      can :read, Activity, { assessments: { account_id: company_employee.dc_company_id } }
      can :manage, Assessment, { account_id: company_employee.dc_company_id }
    elsif company_employee.employee_type == 'Agent'
      can :manage, Assessment, { dc_company_id: company_employee.assigned_company_ids }
      can :manage, Dc::Company, { id: company_employee.assigned_company_ids }
    else
      can :manage, Activity, { dc_company_id: company_employee.dc_company_id }
      can :manage, Assessment, { dc_company_id: company_employee.dc_company_id }
    end
  end
end
