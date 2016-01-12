class SocrataService
  attr_reader :client

  def initialize 
    @client ||= SODA::Client.new({:domain => "data.seattle.gov", :app_token => "xwffIORpk0f1KT1ZtKoXfKUdA"})
  end

  def fetch_seattle_crimes
    responses = client.get("yamw-xkh3", { "$limit" => 1 })
    responses.each do |crime|
      Crime.create!(
        latitude: crime.location.latitude,
        longitude: crime.location.longitude
      )
    end

  end

  private

    def self.client
      SODA::Client.new({domain: 'data.seattle.gov',
                        app_token: ENV['app_token']})
    end
end
