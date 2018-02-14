require 'http'
require 'json'
require './lib/connection'

# Reddit model
#
class Reddit
  SUBSCRIBED = 'https://oauth.reddit.com/subreddits/mine/subscriber'.freeze
  # Returns: Subscribed subreddits used to
  #
  # attr_accessor :subscribed_subreddits

  # Hash that maps subreddit to top post data
  # A Value (top posts) is represented as an array
  # Each index of the array is a hash containing various data about that post
  attr_accessor :top_posts

  def initialize
    @subscribed_subreddits = []
    @top_posts = {}
    @connection = Connection.new
  end

  def top_post(limit)
    if @subscribed_subreddits.empty?
      subscribed_subreddits
    end
    # From specified subscribed subreddits lookup top posts &
    # Digest, another class should handle preparing this information

    # I am only interested subreddits I subscribed to
    # In the future parameterize time
    @subscribed_subreddits.each do |subreddit|
      top_info = @connection.top("https://www.reddit.com/r/#{subreddit}/top/.json?t=day&limit=#{limit}")
      hash = JSON.parse(top_info)['data']['children']
      hash.each do |field|
        subreddit_name = field['data']['subreddit']
        # Another implementation could be store post id and necessary requests, can be done in the future
        data = hash
        @top_posts[subreddit_name.to_sym] = data
      end
    end
  end

  def format
    @top_posts.each do |subreddit, data|
      link = data[0]['data']['permalink']
      @top_posts[subreddit] = link
    end
  end

  private
  def subscribed_subreddits
    subscribed_subreddits_json = @connection.subscribed(SUBSCRIBED)
    subscribed_subreddit_info_hash = JSON.parse(subscribed_subreddits_json)['data']['children']

    subscribed_subreddit_info_hash.each do |subreddit_data|
      @subscribed_subreddits.push(subreddit_data['data']['display_name'])
    end
  end
end
