require 'http'
require 'json'

class RedditHttp
  # @todo Implement auto token refreshal for development
  REFRESH_TOKEN = ''.freeze
  ACCESS_TOKEN = ''.freeze
  SUBSCRIBED = 'https://oauth.reddit.com/subreddits/mine/subscriber'.freeze

  def self.subscribed_subreddits
    subscribed_subreddits_json = HTTP.auth("Bearer #{ACCESS_TOKEN}")
                                     .get(SUBSCRIBED).to_s
    subscribed_subreddit_info_hash = JSON.parse(subscribed_subreddits_json)['data']['children']
    @subscribed_subreddits = []
    subscribed_subreddit_info_hash.each do |subreddit_data|
      @subscribed_subreddits.push(subreddit_data['data']['display_name'])
    end

    puts @subscribed_subreddits
  end
end
