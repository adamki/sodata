class UsersController < ApplicationController
  def update
    User.update(user_params)
    redirect_to dashboard_path
  end

  def destroy
    user = User.find(user_params[:id])
    user.bikes.delete_all
    user.delete
    session.destroy
    flash[:success] = "Account and All bikes hvae been removed"
    redirect_to root_path
  end


  private

  def user_params
    params.permit(:id, 
                  :first_name,
                  :last_name,
                  :image,
                  :google_profile_url,
                  :gender,
                  :uid, 
                  :email,
                  :phone_number, 
                  :gets_alert)
  end
end
