class SeattleController < ApplicationController
  def crime
    socrata_service = SocrataService.new
    @seattle_crimes = socrata_service.fetch_seattle_crimes
  end
end
