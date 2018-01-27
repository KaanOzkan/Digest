require_relative 'reddit_http'

class Driver
  attr_accessor :subreddits
  def initialize
    @subreddits
  end

  def get_subreddits
    @subreddits = RedditHttp.subscribed_subreddits
  end
end
