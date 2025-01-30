# frozen_string_literal: true

class CompanyAbility < BaseAbility
  def initialize(user)
    super()

    if user.employee_type == 'Agent'
      can :manage, Dc::Company, { id: user.assigned_company_ids }
    elsif user.employee_type == 'Admin/Owner'
      can :manage, Dc::Company, { id: user.dc_company_id }
      can :manage, Dc::Company, { id: user.company_linked_companies.pluck(:id) }
    elsif user.company_type_name == 'Account'
      can :manage, Dc::Company, { id: user.dc_company_id }
    end
  end
end
