class Ability
  include CanCan::Ability

  def initialize(user)
    can :access, :rails_admin
    can :manage, :dashboard
    can :read, :all

    if user.present?
      can :manage, User, id: user.id
      can :read, :dashboard

      if user.has_role? :admin
        can :manage, :all
      end
    end
  end
end
