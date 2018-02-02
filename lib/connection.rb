require 'http'

# Handles requests
#
class Connection
  # @todo Implement auto token refreshal for development
  # Reddit
  REFRESH_TOKEN = '55649311-GyspsnQ2RxHsfD8U-2c7LsIzWYc'.freeze
  ACCESS_TOKEN = 'EVzyxQW8ZqVwciTX_-0tNN4eoLA'.freeze

    # @todo Response code checks
    # For development
    def refresh_access_token
      # @todo
    end

  # Reddit
  def self.connect
    HTTP.auth("Bearer #{ACCESS_TOKEN}")
  end

  def self.subscribed(url)
    response = connect.get(url)
    response.to_s if response.code == 200
    return response.to_s unless response.code != 200
    raise("Couldn't get subscribed subreddits, #{response.body}")
  end

  # Does not need authorization
  def self.top(url)
    response = HTTP.get(url)
    return response.to_s unless response.code != 200
    raise("Couldn't get the top posts, #{response.body}")
  end
end
