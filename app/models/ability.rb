class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :commish
      can :manage, :all
    elsif user.role? :chief
      can :read, :all
      can :manage, Investigation
      can :manage, InvestigationNote
      can :manage, CrimeInvestigation
      can :manage, Criminal
      can :manage, Suspect
      can :manage, Assignment
      can :read, Unit
      can :update, Unit do |u|
        user.officer.unit.id == u.id
      end
      can :manage, Officer do |o|
        user.officer.unit.id == o.unit.id
      end
      can [:read, :update], User do |u|
        user.id == u.id
      end
    elsif user.role? :officer
      can [:create, :read], Investigation
      can :update, Investigation do |i|
        my_invests = user.officer.investigations.is_open.map(&:id)
        my_invests.include? i.id
      end
      can :manage, InvestigationNote
      can :read, Assignment
      can :read, Crime
      can :manage, CrimeInvestigation
      can :manage, Criminal
      can :manage, Suspect
      can [:read, :update], Officer do |o|
        user.officer.id == o.id
      end
      can [:read, :update], User do |u|
        user.id == u.id
      end
      can :index, Unit
      can :show, Unit do |u|
        user.officer.unit.id == u.id
      end
    else
      can :read, Crime
    end
  end
end