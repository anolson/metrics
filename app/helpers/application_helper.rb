module ApplicationHelper
  
  def link_to_login_logout
    if has_authenticated?
      link_to "Logout", logout_url
    else
      link_to "Login", login_url(:protocol => protocol_for_environment)
    end
  end

  def protocol_for_environment
    Rails.env.production? ? 'https' : 'http'
  end
  
end
