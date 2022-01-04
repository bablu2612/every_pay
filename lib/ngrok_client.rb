module NgrokClient
    def self.tunnels
      response = Net::HTTP.get(URI('http://localhost:3000/api/tunnels'))
      begin
        JSON.parse(response).dig("tunnels")
      rescue JSON::ParserError => e
        Rails.logger.error %q{
          Failed to parse reponse from Ngroks internal API. Are you sure its running?
        }
      end
    end
    def self.public_urls
      tunnels.select do |h|
        # TODO - don't hardcode the host name
        h.dig("config", "addr") == "http://localhost:3000"
      end.map { |h| URI(h["public_url"]).hostname }.uniq
    end
  end