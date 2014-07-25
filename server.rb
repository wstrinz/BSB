Encoding.default_internal = Encoding.default_external = 'UTF-8'

def path_to(dir)
  File.join(File.dirname(__FILE__), dir)
end

require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'

require 'feedjira'

# Require classes needed for project
require path_to('lib/models/feed')
require path_to('lib/models/story')

require_relative 'lib/routes_helper'
include RoutesHelper

configure do
  set :public_folder, File.expand_path(path_to 'dist')
  api_routes Feed
end

configure :development do
  require 'sinatra/reloader'
  Sinatra::Application.also_reload "lib/**/*.rb"
end


get '*' do
  pass if request.accept.map(&:to_s).include?('application/json')
  send_file 'dist/index.html'
end

get '/feed/:id/stories' do
  content_type :json
  { stories: Feed.find(params[:id]).stories }.to_json
end

get '/stories' do
  content_type :json
  if params[:ids]
    { stories: Story.where(id: params[:ids]) }.to_json
  else
    { stories: Story.all }.to_json
  end
end

get '/stories/:id' do
  content_type :json
  { story: Story.find(params[:id]) }.to_json
end
