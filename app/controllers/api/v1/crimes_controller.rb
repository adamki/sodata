class Api::V1::CrimesController < ApplicationController
  respond_to :json, :html, :xml
  
  def index
    respond_with Crime.all
  end
end
