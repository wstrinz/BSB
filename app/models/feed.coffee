`import DS from 'ember-data'`

Feed = DS.Model.extend
  feed_url: DS.attr('string')
  name: DS.attr('string')
  stories: DS.hasMany('story', {async: true})

`export default Feed`
