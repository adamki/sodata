class SeattleController < ApplicationController
  respond_to :json

  def crime
  end

  def bike_thefts 
    socrata_service = SocrataService.new
    respond_with socrata_service.bike_thefts(params[:lat], params[:lng])
  end
end
