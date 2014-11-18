class AddSiteUrlToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :site_url, :string
  end
end
