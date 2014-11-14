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
  ActiveRecord::Base.logger.level = 1
  count = Story.where(read: false).count
  interval = (count.to_f * 0.01).round
  pretty_percent = ->(num,denom){ ( ( num.to_f / denom.to_f ) * 100 ).round(2) }
  Story.where(read: false).each_with_index do |s, i|
    s.recompute_score
    if i % interval == 0
      ActiveRecord::Base.logger.info "#{pretty_percent.call(i, count)} % of #{count} stories processed"
    end
    s.save!
  end
end
