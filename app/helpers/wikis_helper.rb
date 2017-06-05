module WikisHelper

  def is_authorized
    current_user.role == "premium"
  end

end
