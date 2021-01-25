# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(account)
    if account.admin?
      can :manage, :all
    elsif account.user?
      can :read, Account

      can :read, Document
      can :create, Document
      can :update, Document do |document|
        document.try(:account) == account
      end
      can :destroy, Document do |document|
        document.try(:account) == account
      end
      
      can :read, Folder
      can :create, Folder
      can :update, Folder do |folder|
        folder.try(:account) == account
      end
      can :destroy, Folder do |folder|
        folder.try(:account) == account
      end

    elsif account.guest?
      can :read, Folder
      can :read, Account
      can :read, Document
    end
  end
end
