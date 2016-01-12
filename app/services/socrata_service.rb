class SocrataService
  attr_reader :client

  def initialize 
    @client ||= SODA::Client.new({:domain => "data.seattle.gov", :app_token => ENV["socrata_app_token"]}) 
  end

  def fetch_seattle_crimes
    responses = client.get("yamw-xkh3", { "$limit" => 1000 })
    responses.each do |crime|
      Crime.create!(
        date_reported:          crime.date_reported,
        latitude:               crime.location.latitude,
        longitude:              crime.location.longitude,
        hundred_block_location: crime.hundred_block_location,
        offense_description:    crime.summarized_offense_description,
        offense_code:           crime.offense_code,
        offense_type:           crime.offense_type,
        zone_beat:              crime.zone_beat
      )
    end
  end

  private

    def self.client
      SODA::Client.new({domain: 'data.seattle.gov',
                        app_token: ENV['app_token']})
    end
end
