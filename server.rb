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

configure do
  set :views, File.expand_path(path_to 'dist')
  set :public_folder, File.expand_path(path_to 'dist')
end

configure :development do
  require 'sinatra/reloader'
  Sinatra::Application.also_reload "lib/**/*.rb"
end

get '/' do
  send_file 'dist/index.html'
end

get '/feeds' do
  redirect to('/') unless request.accept.map(&:to_s).include?("application/json")
  content_type :json
  {feeds: Feed.all}.to_json
end
