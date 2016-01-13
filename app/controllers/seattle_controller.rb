class SeattleController < ApplicationController
  def crime
    @seattle_crimes = Crime.first(3)
    socrata_service = SocrataService.new
    @bike_thefts = socrata_service.fetch_seattle_crimes
  end
end
