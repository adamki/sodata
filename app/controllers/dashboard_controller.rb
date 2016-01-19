class DashboardController < ApplicationController
  def show
    @bikes = current_user.bikes
    redirect_to root_path if !current_user
  end
end
