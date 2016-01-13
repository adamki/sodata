class SocrataService
  attr_reader :client

  def initialize
    @client ||= SODA::Client.new({
      :domain => "data.seattle.gov", 
      :app_token => ENV["socrata_app_token"]
    })
  end

  def fetch_crimes
    client.get("yamw-xkh3", 
               { "$limit" => 50 })
  end

  def fetch_thefts
    client.get("yamw-xkh3", 
               {"$where"  => "offense_code = '2399'", "$limit" => 20})
  end

  def fetch_bike_racks
    client.get("svqu-nfve", 
               {"$limit" => 100})
  end

end
