require 'test_helper'
require './lib/reddit'

# @todo
HASH = {:sports=>[{"kind"=>"t3", "data"=>{"domain"=>"v.redd.it", "approved_at_utc"=>nil, "mod_reason_by"=>nil, "banned_by"=>nil, "num_reports"=>nil, "subreddit_id"=>"t5_2qgzy", "subreddit"=>"sports", "post_hint"=>"hosted:video","permalink"=>"/r/sports/comments/7x68xs/chloe_kim_land_backtoback_1080s_for_the_first/"}}]}
EXPECTED = {:sports=>"/r/sports/comments/7x68xs/chloe_kim_land_backtoback_1080s_for_the_first/"}

class RedditTest < Minitest::Test
  def setup
    @reddit = Reddit.new
  end

  def test_format
    @reddit.top_posts = HASH
    assert_equal(@reddit.format, EXPECTED)
  end
end
