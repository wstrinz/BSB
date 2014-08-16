`import DS from 'ember-data'`
`import Ember from 'ember'`

Story = DS.Model.extend
  title: DS.attr('string')
  author: DS.attr('string')
  url: DS.attr('string')
  published: DS.attr('date')
  fetched_at: DS.attr('date')
  timestamp: DS.attr('date')
  read: DS.attr('boolean')
  summary: DS.attr('string')
  story_content: DS.attr('string')
  feed: DS.belongsTo('feed')
  human_time: Ember.computed 'timestamp', ->
    moment(@get('timestamp')).format('LLL')

`export default Story`
