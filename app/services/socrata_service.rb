class SocrataService
  attr_reader :conn

  def initialize
    @conn = Faraday.new(:url => 'https://data.seattle.gov/') do |faraday|
      faraday.request  :url_encoded            
      faraday.response :logger                 
      faraday.adapter  Faraday.default_adapter 
    end
  end

  def build_crimes(lat, lng, dist, limit = 30)
    {
      crimes: get_thefts(lat, lng, dist, limit),
      times: with_crime_count(get_thefts(lat, lng, dist, limit)),
      racks: get_racks(lat, lng, dist)
    }
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_thefts(lat, lng, dist, limit = 30)
    thefts = conn.get "resource/i47f-eseg.json?$where=within_circle(location,%20#{lat},%20#{lng},%20#{dist})&$limit=#{limit}"
    response = parse(thefts)
    filter_date_reported(response)
  end

  def get_racks(lat, lng, dist)
    racks = conn.get "resource/69v5-5c5g.json?$where=within_circle(rack_location,%20#{lat},%20#{lng},%20#{dist})"
    parse(racks)
  end

  def with_crime_count(crimes)
    crimes.each_with_object({}) do |crime, acc|
      hour = crime[:date_reported]
      count = acc.fetch(hour, 0)
      acc[hour] = count + 1
    end
  end

  def filter_date_reported(response_collection)
    formatted_collection = response_collection.each do |response|
      hour = DateTime.parse(response[:date_reported]).hour

      response[:date_reported] = Time.parse("#{hour}:00").strftime("%l %P").delete(' ')
    end
  end

end
