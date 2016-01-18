class Bike < ActiveRecord::Base
  belongs_to :user

  def self.create(params, user)
    Bike.create!(
      make:          params[:make],
      model:         params[:model],
      description:   params[:description],
      serial_number: params[:serial_number],
      terrain:       params[:terrain],
      user_id:       user.id
    ) 
  end
end
