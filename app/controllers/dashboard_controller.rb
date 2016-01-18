class DashboardController < ApplicationController
  def show
    redirect_to root_path if !current_user
    @bikes = current_user.bikes
  end
end
