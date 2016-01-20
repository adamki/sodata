class BikesController < ApplicationController

  def create 
    Bike.create(bike_params, current_user) if current_user
    redirect_to :back
  end

  def missing
    bike = Bike.find(bike_params[:id])
    message = build_message(bike)
    TwilioService.new.build_sms(message)
    NotificationsMailer.send_stolen_alert(current_user, bike).deliver
    redirect_to :back
  end

  def destroy 
    bike = Bike.find(bike_params[:id])
    bike.delete
    redirect_to dashboard_path
  end

  private

  def build_message(bike)
    "Please be on the lookout for a '#{bike.model} #{bike.make}', serial number #{bike.serial_number} that was stolen on #{Time.now}"
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
