require './lib/reddit'

# @todo Delete
class Driver
  attr_accessor :subreddits
  def initialize
    @subreddits
  end

  # Trigger in driver instead of init
  def get_subreddits
    reddit = Reddit.new
    # Get subscribed_subreddits before looking for top
    reddit.subscribed_subreddits
    # Should receive the limit from the router
    reddit.top_posts(2)
    reddit.format
  end
end
