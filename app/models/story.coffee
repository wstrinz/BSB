`import DS from 'ember-data'`
`import Ember from 'ember'`

Story = DS.Model.extend
  title: DS.attr 'string'
  author: DS.attr 'string'
  url: DS.attr 'string'
  published: DS.attr 'date'
  fetched_at: DS.attr 'date'
  timestamp: DS.attr 'date'
  read: DS.attr 'boolean'
  summary: DS.attr 'string'
  story_content: DS.attr 'string'
  sharecount: DS.attr 'number'
  score: DS.attr 'number'
  feed: DS.belongsTo 'feed'
  faviconUrl: Ember.computed 'url', ->
    "http://www.google.com/s2/favicons?domain=#{@get('url')}"
  human_time: Ember.computed 'timestamp', ->
    moment(@get 'timestamp').calendar()

`export default Story`
