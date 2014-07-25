require_relative 'spec_helper'

describe 'Feed Server' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'runs' do
    header "ACCEPT", "text/html"
    get '/'
    expect(last_response).to be_ok
  end

  describe 'Feeds' do
    before do
      create :feed
    end

    let(:feeds_json) { { feeds: Feed.all }.to_json(methods: :story_ids) }
    let(:feed_1_json) { { feed: Feed.first }.to_json(methods: :story_ids) }

    it 'gets all feeds' do
      header "ACCEPT", "application/json"
      get '/feeds'
      expect(JSON.parse last_response.body).to eq(JSON.parse feeds_json)
    end

    it 'gets individual feed' do
      header "ACCEPT", "application/json"
      get '/feeds/1'
      expect(JSON.parse last_response.body).to eq(JSON.parse feed_1_json)
    end
  end

  describe 'Stories' do
    before do
      create :story
    end

    let(:stories_json) { { stories: Story.all }.to_json }
    let(:story_1_json) { { story: Story.first }.to_json }

    it 'gets all feeds' do
      header "ACCEPT", "application/json"
      get '/stories'
      expect(JSON.parse last_response.body).to eq(JSON.parse stories_json)
    end

    it 'gets individual feed' do
      header "ACCEPT", "application/json"
      get '/stories/1'
      expect(JSON.parse last_response.body).to eq(JSON.parse story_1_json)
    end
  end
end
