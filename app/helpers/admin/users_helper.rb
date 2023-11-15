module Admin
  module UsersHelper
    def user_roles
      User.roles.keys.map do |role|
        [ role.titleize, role ]
      end
    end

    
    def user_is_admin
      return if current_user.role == "admin"
      flash[:warning] = 'You are no admin!'
      redirect_to root_path
    end
  end
end