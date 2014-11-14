Encoding.default_internal = Encoding.default_external = 'UTF-8'

def path_to(dir)
  File.join(File.dirname(__FILE__), dir)
end

require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require 'will_paginate'
require 'will_paginate/active_record'

require 'feedjira'

require path_to('lib/models/feed')
require path_to('lib/models/story')
require path_to('lib/models/feeds/hacker_news')

require_relative 'lib/routes_helper'
include RoutesHelper

use Rack::Deflater

class ApiKeys
  class << self
    attr_writer :keys

    def keys
      @keys ||= {}
    end

    def load(h)
      keys.merge(h)
      h.each do |k,v|
        ENV[k.to_s] = v
      end
    end
  end
end

configure do
  set :public_folder, File.expand_path(path_to 'dist')
  if File.exist? 'secrets.yml'
    ApiKeys.load YAML.load open('secrets.yml').read
  else
    puts 'No secrets.yml found, some integrations may be unavailable'
  end
end

configure :development do
  require 'sinatra/reloader'
  Sinatra::Application.also_reload "lib/**/*.rb"
end

get '*' do
  accepts_json = request.accept.map(&:to_s).include?('application/json')
  only_accepts_all = request.accept.first.to_s == '*/*'
  pass if accepts_json || only_accepts_all
  send_file 'dist/index.html'
end

get '/stories' do
  content_type :json
  query_opts = {}
  query_opts[:id] = params[:ids] if params[:ids]
  query_opts[:feed_id] = params[:feed_id] if params[:feed_id]
  query_opts[:read] = (params[:read] == "true") if params[:read]
  order = params[:sort] if params[:sort]
  page = params[:page] || 1

  resp = if order
           { stories: Story.where(query_opts)
             .order(order => :desc)
             .paginate(page: page, per_page: 15) }
         else
           { stories: Story.where(query_opts).paginate(page: page) }
         end

  resp.to_json
end

post '/feeds' do
  data = JSON.parse(request.body.read)
  Feed.create!(data["feed"])
end

put '/stories/:id' do
  post_params = JSON.parse(request.body.read)
  Story.find(params[:id]).update_attributes(post_params["story"])
end

put '/feeds/:id' do
  post_params = JSON.parse(request.body.read)
  Feed.find(params[:id]).update_attributes(post_params["feed"])
end

api_routes Feed
api_routes Story
