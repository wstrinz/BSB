require File.expand_path(File.join(File.dirname(__FILE__), *%w[server]))
require "sinatra/activerecord/rake"

desc "Update All Feeds"
task :update_feeds do
  Feed.all.each do |f|
    f.update
  end
end
