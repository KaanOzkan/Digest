require 'http'
require 'json'

# Handles requests for various media
#
class Connection

  # Reddit
  def initialize
    @reddit_refresh_token = '55649311-GyspsnQ2RxHsfD8U-2c7LsIzWYc'
    @reddit_access_token  =  '14FjeJ1h-iqVGsaodiZoH-mtC_A'
  end

  def refresh_access_token
    response = HTTP.basic_auth(user: 'f0swaO18dSYpNQ',
                               pass: 'V2vi9PPNYvkkHzQM0_Aw_ovq33k')
    body_param = { grant_type: 'refresh_token',
                   refresh_token: @reddit_refresh_token,
                   redirect_uri: 'https://www.reddit.com' }
    response = response.post('https://www.reddit.com/api/v1/access_token',
                              form: body_param)
    @reddit_access_token = JSON.parse(response.to_s)['access_token']
    # For development
    puts "New Access Token: #{@reddit_access_token}"
  end

  def connect
    HTTP.auth("Bearer #{@reddit_access_token}")
  end

  def subscribed(url)
    response = connect.get(url)
    if response.code == 401 # unauthorized, try again
      refresh_access_token
      response = connect.get(url)
    end
    return response.to_s if response.code == 200
    raise("Couldn't get subscribed subreddits, #{response.body}")
  end

  # Does not need authorization
  def top(url)
    response = HTTP.get(url)
    return response.to_s unless response.code != 200
    raise("Couldn't get the top posts, #{response.body}")
  end
end
