class SeattleController < ApplicationController
  def crime
    @ss = SocrataService.seattle_crime(10)
  end
end
