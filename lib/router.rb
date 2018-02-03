require 'sinatra'

class DigestApp < Sinatra::Base
  get '/' do
    "Welcome to Digest"
  end

  # Currently only supporting reddit
  get '/media/:name' do
    halt 404, 'Media not found' unless params[:name].downcase == 'reddit'
    reddit = Reddit.new
    reddit.top_post(1)
    reddit.top_posts[:Gunners][0]['data']['permalink']
  end

  get '/*' do
     # Handle if necessary
     halt 404
  end
end
