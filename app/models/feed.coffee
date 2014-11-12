`import DS from 'ember-data'`

Feed = DS.Model.extend
  feed_url: DS.attr('string')
  name: DS.attr('string')
  unread_count: DS.attr('number')
  time_decay: DS.attr('boolean')
  stories: DS.hasMany('story', {async: true})

`export default Feed`
