`import DS from 'ember-data'`

Feed = DS.Model.extend
  feed_url: DS.attr('string')
  site_url: DS.attr('string')
  name: DS.attr('string')
  unread_count: DS.attr('number')
  time_decay: DS.attr('boolean')
  time_decay_interval: DS.attr('number')
  faviconUrl: Ember.computed 'feed_url', -> "http://g.etfv.co/#{@get('site_url')}"
  stories: DS.hasMany('story', {async: true})

`export default Feed`
