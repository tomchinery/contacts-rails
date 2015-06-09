class HomeController < ApplicationController

  helper_method :current_user

  def index

    @contacts = Contact.all!(current_user.oauth_token, current_user.email) if current_user

  end
end
