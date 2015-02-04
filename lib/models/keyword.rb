class Keyword < ActiveRecord::Base
  belongs_to :story
  validate :name, uniqueness: { scope: :story, message: "Keywords must be unique for each story" }
end
