require 'sinatra'
require 'json'
class DigestApp < Sinatra::Base
  get '/' do
    "Welcome to Digest"
  end

  # Currently only supporting reddit
  get '/media/:name.json' do
    halt 404, 'Media not found' unless params[:name].casecmp('reddit')
    reddit = Reddit.new
    reddit.top_post(1)
    # @todo Delete
    content_type :json

    hash = reddit.top_post(1)
    reddit.format(hash).to_json
  end

  get '/*' do
     # Handle if necessary
     halt 404
  end
end
