class SeattleController < ApplicationController
  def crime
    @seattle_crimes = Crime.all
  end
end
