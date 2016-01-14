class SocrataService
  attr_reader :client, :conn

  def initialize
    @conn = Faraday.new(:url => 'https://data.seattle.gov/resource/i47f-eseg.json') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def bike_thefts(lat, lng, dist = 500)
    response = conn.get "?$where=within_circle(location,%20#{lat},%20#{lng},%20#{dist})"
    responses = parse(response)
    formatter(responses)
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def formatter(responses)
    responses.map do |response|
      [response[:hundred_block_location],
       response[:location][:latitude],
       response[:location][:longitude]]
    end
  end

end
