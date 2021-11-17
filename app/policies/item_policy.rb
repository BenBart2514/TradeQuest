# frozen_string_literal: true

class ItemPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.has_role? :admin
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    user.has_role? :admin
  end

  def destroy?
    user.has_role? :admin
  end

  def buy?
    true
  end

  def sell?
    true
  end

  def buyback?
    true
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
