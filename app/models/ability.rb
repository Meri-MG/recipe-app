class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    if user.nil? # Insted of `user ||= User.new` # guest user (not logged in)
      can :read, Recipe, public: true
      return
    end

    can :manage, :all if user.admin?

    can :read, Recipe, public: true
    can :manage, Recipe, user_id: user.id
    can :manage, Food, user_id: user.id
    can :manage, Inventory, user_id: user.id
    can :manage, InventoryFood, inventory: { user_id: user.id }
    can :manage, RecipeFood, recipe: { user_id: user.id }

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
