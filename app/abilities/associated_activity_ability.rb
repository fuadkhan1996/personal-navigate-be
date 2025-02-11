# frozen_string_literal: true

class AssociatedActivityAbility < BaseAbility
  def initialize(user)
    super()

    return unless user.company_type_name == 'Account'

    can :read, AssociatedActivity, { assessment: { account_id: user.dc_company_id } }
    can :read, AssociatedActivity, { company_id: user.dc_company_id }
  end
end
