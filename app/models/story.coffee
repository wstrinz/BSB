`import DS from 'ember-data'`

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

`export default Story`
