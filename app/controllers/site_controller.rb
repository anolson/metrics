class SiteController < ApplicationController
  skip_filter :verify_user_authentication

  def index; end
end
