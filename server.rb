Encoding.default_internal = Encoding.default_external = 'UTF-8'

def path_to(dir)
  File.join(File.dirname(__FILE__), dir)
end

require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'

require 'erb'
require 'haml'
require 'sass/plugin/rack'

require 'feedjira'

# Require classes needed for project
require path_to('lib/models/feed.rb')

use Sass::Plugin::Rack

configure do
  set :views, File.expand_path(path_to 'dist')
  set :public_folder, File.expand_path(path_to 'dist')
  set :haml, { :attr_wrapper => '"', :format => :html5 }
  set :database, { adapter: "sqlite3", database: "feed-ember.sqlite3" }
end

configure :development do
  require 'sinatra/reloader'
  Sinatra::Application.also_reload "lib/**/*.rb"
end

get '/' do
  send_file 'dist/index.html'
end

get '/feeds' do
  content_type :json
  {feeds: Feed.all}.to_json
end
