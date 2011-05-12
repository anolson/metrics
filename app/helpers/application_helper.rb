module ApplicationHelper
  
  def link_to_login_logout
    if has_authenticated?
      link_to "Logout", logout_path
    else
      link_to "Login", login_path
    end
  end
  
end
