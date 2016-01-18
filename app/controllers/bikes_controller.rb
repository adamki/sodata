class BikesController < ApplicationController

  def create 
    Bike.create(bike_params, current_user) if current_user
    redirect_to :back
  end

  def bike_params
    params.permit(:make, :model, :description, :serial_number, :terrain)
  end
end
