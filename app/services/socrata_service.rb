class SocrataService
  attr_reader :client

  def initialize
    @client ||= SODA::Client.new({:domain => "data.seattle.gov", 
                                  :app_token => ENV["socrata_app_token"]})
  end

  def fetch_seattle_crimes
    response = client.get("yamw-xkh3", { "$limit" => 100 })
  end

  def fetch_bike_thefts
    responses = client.get("cd63-bj4a")
  end


  private
    def self.client
      SODA::Client.new({domain: 'data.seattle.gov',
                        app_token: ENV['app_token']})
    end
end
