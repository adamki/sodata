class SocrataService
  attr_reader :client, :conn

  def initialize
    @conn = Faraday.new(:url => 'https://data.seattle.gov/') do |faraday|
      faraday.request  :url_encoded            
      faraday.response :logger                 
      faraday.adapter  Faraday.default_adapter 
    end
  end

  def build_crimes(lat, lng, dist = 500, limit = 30)
    {
      crimes: get_thefts(lat, lng, dist, limit),
      times: with_crime_count(get_thefts(lat, lng, dist, limit)),
      racks: get_racks(lat, lng)
    }
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_thefts(lat, lng, dist = 500, limit = 30)
    thefts = conn.get "resource/i47f-eseg.json?$where=within_circle(location,%20#{lat},%20#{lng},%20#{dist})&$limit=#{limit}"
    response = parse(thefts)
    filter_date_reported(response)
  end

  def get_racks(lat, lng, dist = 700)
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
    response_collection.each do |response|
      case response[:date_reported][-8,2]
      when "01"
        response[:date_reported] = "1AM"
      when "02"
        response[:date_reported] = "2AM"
      when "03"
        response[:date_reported] = "3AM"
      when "04"
        response[:date_reported] = "4AM"
      when "05"
        response[:date_reported] = "5AM"
      when "06"
        response[:date_reported] = "6AM"
      when "07"
        response[:date_reported] = "7AM"
      when "08"
        response[:date_reported] = "8AM"
      when "09"
        response[:date_reported] = "9AM"
      when "10"
        response[:date_reported] = "10AM"
      when "11"
        response[:date_reported] = "11AM"
      when "12"
        response[:date_reported] = "12PM"
      when "13"
        response[:date_reported] = "1PM"
      when "14"
        response[:date_reported] = "2PM"
      when "15"
        response[:date_reported] = "3PM"
      when "16"
        response[:date_reported] = "4PM"
      when "17"
        response[:date_reported] = "5PM"
      when "18"
        response[:date_reported] = "6PM"
      when "19"
        response[:date_reported] = "7PM"
      when "20"
        response[:date_reported] = "8PM"
      when "21"
        response[:date_reported] = "9PM"
      when "22"
        response[:date_reported] = "10PM"
      when "23"
        response[:date_reported] = "11PM"
      when "00"
        response[:date_reported] = "12PM"
      end
    end
  end
end
