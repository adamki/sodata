class SeattleController < ApplicationController
  def crime
    @ss = SocrataService.seattle_crime(100)
  end
end
