`import Ember from 'ember'`

C = Ember.ArrayController.extend
  sortProperties: ['name'],
  sortAscending: true,
  add_feed: ->
    url = Ember.$('#add_feed').val()
    new_feed = @store.createRecord 'feed', {feed_url: url, name: 'temp'}
    new_feed.save()

`export default C`
