`import DS from 'ember-data'`

Feed = DS.Model.extend
  feed_url: DS.attr('string')
  site_url: DS.attr('string')
  name: DS.attr('string')
  unread_count: DS.attr('number')
  time_decay: DS.attr('boolean')
  time_decay_interval: DS.attr('number')
  boost: DS.attr('number')
  faviconUrl: Ember.computed 'site_url', -> "http://www.google.com/s2/favicons?domain=#{@get('site_url')}"
  stories: DS.hasMany('story', {async: true})

`export default Feed`
