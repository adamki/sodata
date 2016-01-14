class SeattleController < ApplicationController
  respond_to :json

  def crime
    socrata_service = SocrataService.new
    @bike_thefts = socrata_service.fetch_thefts
    @bike_racks = socrata_service.fetch_bike_racks
  end

  def get_crimes
    socrata_service = SocrataService.new
    respond_with socrata_service.fetch_crimes(params[:lat], params[:lng])
  end
end
