Encoding.default_internal = Encoding.default_external = 'UTF-8'

def path_to(dir)
  File.join(File.dirname(__FILE__), dir)
end

require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require 'will_paginate'
require 'will_paginate/active_record'

require 'newrelic_rpm'

require 'omniauth'
require 'omniauth-github'
require 'omniauth-pocket'

require 'rack/ssl-enforcer'

require 'feedjira'

require path_to('lib/models/feed')
require path_to('lib/models/story')
require path_to('lib/models/story_archives')
require path_to('lib/models/shortcut')
require path_to('lib/models/feeds/hacker_news')
require path_to('lib/background_jobs/recompute_job')

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

helpers do

  def is_owner?
    session.to_hash.fetch("auth_hash",{}).fetch("info", {}).fetch("email",{}) == ENV['GITHUB_OWNER_EMAIL']
  end

  def authenticated?
    session[:authenticated] && is_owner?
  end

  def ensure_authenticated
    unless authenticated?
      authenticate!
    end
  end

  def authenticate!
    unless self.class.production?
      session[:authenticated] = true
      session[:auth_hash] = {"info" => {"email" => ENV['GITHUB_OWNER_EMAIL']}}
      redirect '/'
    else
      redirect '/auth/github'
    end
  end

  def authenticate_pocket!
    redirect '/auth/pocket'
  end

  def logout!
    session.clear
  end
end

configure do
  set :public_folder, File.expand_path(path_to 'dist')
  if File.exist? 'secrets.yml'
    ApiKeys.load YAML.load open('secrets.yml').read
  else
    puts 'No secrets.yml found, some integrations may be unavailable'
  end

  use OmniAuth::Builder do
    user_scopes = 'user,repo,read:repo_hook,write:repo_hook,admin:repo_hook,read:org'
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: user_scopes
    provider :pocket, client_id: ENV['POCKET_CONSUMER_KEY']
  end

  enable :sessions
end

configure :development do
  require 'sinatra/reloader'
  Sinatra::Application.also_reload "lib/**/*.rb"
end

get '/recompute_status' do
  job_status = RecomputeJob.poll
  content_type :json
  {status: job_status.to_s, code: status}.to_json
end

get '/login' do
  authenticate!
end

get '/pocket_login' do
  redirect '/auth/pocket'
  #authenticate_pocket!
end

get '/logout' do
  logout!
  redirect '/'
end

get '/api/stories' do
  content_type :json
  query_opts = {}
  query_opts[:id] = params[:ids] if params[:ids]
  query_opts[:feed_id] = params[:feed_id] if params[:feed_id]
  query_opts[:read] = (params[:read] == "true") if params[:read]
  order = params[:sort] if params[:sort]
  page = params[:page] || 1
  per_page = params[:per_page] || 10

  resp = if order
           { stories: Story.where(query_opts)
             .order(order => :desc)
             .paginate(page: page, per_page: per_page) }
         else
           { stories: Story.where(query_opts).paginate(page: page, per_page: per_page) }
         end

  resp[:meta] = { total_pages: Story.where(query_opts).count / per_page.to_i }

  resp.to_json
end


get '/auth/:provider/callback' do
  content_type :json

  auth_hash = request.env['omniauth.auth']
  if params[:provider] == 'github'
    session[:authenticated] = true
    session[:auth_hash] = auth_hash
    redirect "/"
  elsif params[:provider] == 'pocket'
    session[:pocket_authenticated] = true
    session[:pocket_name] = auth_hash["uid"]
    session[:pocket_token] = auth_hash["credentials"]["token"]
    redirect "/"
  end
end

post '/api/feeds' do
  if authenticated?
    data = JSON.parse(request.body.read)
    Feed.create!(data["feed"].delete_if{|k,v| v == nil})
  else
    status 401
  end
end

post '/recompute_scores' do
  if authenticated?
    RecomputeJob.run
  else
    status 401
  end
end

put '/api/stories/:id' do
  if authenticated?
    post_params = JSON.parse(request.body.read)
    Story.find(params[:id]).update_attributes(post_params["story"])
  else
    status 401
  end
end

put '/api/feeds/:id' do
  if authenticated?
    post_params = JSON.parse(request.body.read)
    Feed.find(params[:id]).update_attributes(post_params["feed"])
  else
    status 401
  end
end

put '/api/shortcuts/:id' do
  if authenticated?
    post_params = JSON.parse(request.body.read)
    Shortcut.find(params[:id]).update_attributes(post_params["shortcut"])
  else
    status 401
  end
end

post '/api/shortcuts' do
  if authenticated?
    data = JSON.parse(request.body.read)
    Shortcut.create!(data["shortcut"].delete_if{|k,v| v == nil})
  else
    status 401
  end
end

delete '/api/shortcuts/:id' do
  if authenticated?
    s = Shortcut.find(params[:id])
    if s.present?
      s.destroy
    else
      status 404
    end
  else
    status 401
  end
end

get '/loggedIn' do
  content_type :json
  logged_in = session[:authenticated]
  owner = authenticated?
  {logged_in: logged_in, owner: owner}.to_json
end

get '*' do
  accepts_json = request.accept.map(&:to_s).include?('application/json')
  only_accepts_all = request.accept.first.to_s == '*/*'
  pass if accepts_json || only_accepts_all || request.path[/\/auth/]
  send_file 'dist/index.html'
end

api_routes Feed
api_routes Story
api_routes Shortcut
