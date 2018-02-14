require 'test_helper'
require './lib/connection'

SUBSCRIBED = 'https://oauth.reddit.com/subreddits/mine/subscriber'.freeze
TOP =  'https://www.reddit.com/r/lakers/top/.json?t=day&limit=1'
class ConnTest < Minitest::Test
  def setup
  end

  def test_subscribed
    # Exception thrown if fail
    Connection.subscribed(SUBSCRIBED)
  end

  def test_top
    # Exception thrown if fail
    Connection.top(TOP)
  end
end
