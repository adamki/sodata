class BikesController < ApplicationController

  def create 
    Bike.create(bike_params, current_user) if current_user
    redirect_to :back
  end

  def destroy 
    bike = Bike.find(bike_params[:id])
    bike.delete
    redirect_to dashboard_path
  end

  def bike_params
    params.permit(:make, 
                  :model, 
                  :description, 
                  :serial_number, 
                  :terrain,
                  :id,
                  :authenticity_token,
                  :_method)
  end
end
