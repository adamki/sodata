class SocrataService
  attr_reader :client

  def initialize
    @client ||= SODA::Client.new({:domain => "data.seattle.gov", :app_token => ENV["socrata_app_token"]})
  end

  def fetch_seattle_crimes
    response = client.get("yamw-xkh3", { "$limit" => 100 })
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
