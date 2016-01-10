class CrimesController < ApplicationController
  def index
    @ss = SocrataService.get_data
  end
end
