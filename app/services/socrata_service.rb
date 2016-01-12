class SocrataService
  attr_reader :client

  def initialize 
    @client ||= SODA::Client.new({:domain => "data.seattle.gov", :app_token => ENV["socrata_app_token"]}) 
  end

  def fetch_seattle_crimes
    responses = client.get("yamw-xkh3", { "$limit" => 100 })
    responses.each do |crime_data|
      crime = Crime.find_or_create_by( date_reported: crime_data.date_reported )
      crime.update_attributes(
        date_reported:          crime_data.date_reported,
        latitude:               crime_data.location.latitude,
        longitude:              crime_data.location.longitude,
        hundred_block_location: crime_data.hundred_block_location,
        offense_description:    crime_data.summarized_offense_description,
        offense_code:           crime_data.offense_code,
        offense_type:           crime_data.offense_type,
        zone_beat:              crime_data.zone_beat
      )
      Rails.logger.info("updated crimes with: #{crime.offense_description} at:#{Time.now}")
      crime.save
      crime
    end
  end

  def self.print_text
    puts "Hello"
  end

  private
    def self.client
      SODA::Client.new({domain: 'data.seattle.gov',
                        app_token: ENV['app_token']})
    end
end
