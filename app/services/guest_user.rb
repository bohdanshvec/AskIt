# frozen_string_literal: true

class GuestUser
  def guest?
    true
  end

  def author?(_)
    false
  end

  def method_missing(name, *args, &)
    return false if name.to_s.end_with?('_role?')

    super(name, *args, &)
  end

  def respond_to_missing(name, include_pivate)
    return true if name.to_s.end_with?('_role?')

    super(name, include_pivate)
  end
end
