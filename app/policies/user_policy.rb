# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    false
  end

  def create?
    user.guest?
  end

  def update?
    record == user
  end

  def show?
    true
  end

  def destroy?
    false
  end
end
