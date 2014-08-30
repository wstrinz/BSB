`import Ember from 'ember'`

C = Ember.ArrayController.extend
  needs: ['application', 'stories']
  sortProperties: ['name'],
  sortAscending: true,
  add_feed: ->
    url = Ember.$('#add_feed').val()
    new_feed = @store.createRecord 'feed', {feed_url: url, name: 'temp'}
    new_feed.save()

  actions:
    toggleShowRead: ->
      @set 'controllers.application.showRead', !@get('controllers.application.showRead')
      false

    cycleSort: ->
      @set 'controllers.application.storySort', @get('controllers.application.nextSort')
      @get('controllers.stories').send 'resetFocus', true

`export default C`
