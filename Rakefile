require File.expand_path(File.join(File.dirname(__FILE__), *%w[server]))
require "sinatra/activerecord/rake"

desc "Update All Feeds"
task :update_feeds do
  ActiveRecord::Base.logger.level = 1
  Feed.all.each do |f|
    f.update
  end
end

desc "Clear database of stories"
task :clear_stories do
  Story.destroy_all
end

desc "Refresh share counts"
task :refresh_sharecounts do
  Story.refresh_sharecounts
end

desc "Refresh share counts"
task :recompute_scores do
  Story.all.each do |s|
    s.recompute_score
    s.save!
  end
end
