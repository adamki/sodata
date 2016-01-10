require 'soda/client'

class SocrataService
  def initialize
    #client = SODA::Client.new({:domain => "explore.data.gov", :app_token => "TBNGvVuq4DQBygUqztyGbizM4"})
    #response = client.get("644b-gaut", {"$limit" => 1, :namelast => "WINFREY", :namefirst => "OPRAH"})
  end

  def self.get_data
    client = SODA::Client.new({:domain => 'data.seattle.gov'})
    response = client.get("yamw-xkh3",
                          {"$limit" => "50000"})
  end
end
