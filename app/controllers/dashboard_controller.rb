class DashboardController < ApplicationController
  def show
    if current_user
      @bikes = current_user.bikes
    else
      redirect_to login_path
    end
  end
end
