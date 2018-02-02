require './lib/reddit'

class Driver
  attr_accessor :subreddits
  def initialize
    @subreddits
  end

  # Trigger in driver instead of init, more testable
  def get_subreddits
    reddit = Reddit.new
    # Get subscribed_subreddits before looking for top
    reddit.subscribed_subreddits
    reddit.top_posts
  end
end
