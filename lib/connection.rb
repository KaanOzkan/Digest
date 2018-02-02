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
    connect.get(url).to_s
  end

  # Does not need authorization
  def self.top(url)
    HTTP.get(url).to_s
  end
end
