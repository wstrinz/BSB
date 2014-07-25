FactoryGirl.define do
  factory :story do
    author 'dr example'
    title 'Example Story'
    url 'http://example.org'
    summary 'short summary'
    story_content '<h1>content for reading yay</h1>'
    feed
  end
end
