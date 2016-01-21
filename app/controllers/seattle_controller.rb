class SeattleController < ApplicationController
  respond_to :json

  def bike_thefts 
    socrata_service = SocrataService.new
    respond_with socrata_service.build_crimes(params[:lat], params[:lng], params[:radius])
  end
end
