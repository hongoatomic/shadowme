class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def create?
    user.student?
  end
  def show?
    is_owner?
  end
  def update?
    is_owner?
  end
  def destroy?
    is_owner?
  end
  def confirm?
    is_owner?
  end
  def decline?
    is_owner?
  end

  private

  def is_owner?
    record.user == user
  end
end
