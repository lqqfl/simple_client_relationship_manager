class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    flash[:notice] = "Welcome to Simple CRM!"
    if User.count == 0
      flash[:alert] =  "You should add a user firstly."
    end
  end

end
