class SeattleController < ApplicationController
  def crime
    socrata_service = SocrataService.new
    @seattle_crimes = socrata_service.fetch_crimes
    @bike_thefts = socrata_service.fetch_thefts
    @bike_racks = socrata_service.fetch_bike_racks
  end
end
