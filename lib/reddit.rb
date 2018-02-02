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
  end

  def top_posts
    if @subscribed_subreddits.empty?
      # Someone forgot!
      subscribed_subreddits
    end

    # From specified subscribed subreddits lookup top posts &
    # Digest, another class should handle preparing this information

    # I am only interested subreddits I subscribed to
    # In the future parameterize time and limit
    @subscribed_subreddits.each do |subreddit|
      top_info = Connection.top("https://www.reddit.com/r/#{subreddit}/top/.json?t=day&limit=2")
      hash = JSON.parse(top_info)['data']['children']
      hash.each do |field|
        subreddit_name = field['data']['subreddit']
        # data contains detailed information about top posts
        data = hash
        @top_posts[subreddit_name.to_sym] = data
      end
    end
    # This is how to access information for a post given subreddit
    # puts @top_posts[:Gunners][0]['data']['title']
  end

  def subscribed_subreddits
    subscribed_subreddits_json = Connection.subscribed(SUBSCRIBED)
    subscribed_subreddit_info_hash = JSON.parse(subscribed_subreddits_json)['data']['children']

    subscribed_subreddit_info_hash.each do |subreddit_data|
      @subscribed_subreddits.push(subreddit_data['data']['display_name'])
    end
  end
end
