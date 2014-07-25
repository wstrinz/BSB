Encoding.default_internal = Encoding.default_external = 'UTF-8'

def path_to(dir)
  File.join(File.dirname(__FILE__), dir)
end

require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'

require 'feedjira'

require path_to('lib/models/feed')
require path_to('lib/models/story')

require_relative 'lib/routes_helper'
include RoutesHelper

configure do
  set :public_folder, File.expand_path(path_to 'dist')
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

post '/feeds' do
  require 'pry'; binding.pry
end

api_routes Feed
api_routes Story
