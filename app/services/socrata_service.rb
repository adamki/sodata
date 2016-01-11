class SocrataService
  def self.seattle_crime(qty)
    client.get("yamw-xkh3", { "$limit" => "#{qty}" })
  end

  private

    def self.client
      SODA::Client.new({domain: 'data.seattle.gov',
                        app_token: ENV['app_token']})
    end
end
