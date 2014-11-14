`import Ember from 'ember'`

C = Ember.ArrayController.extend
  needs: ['application', 'stories']
  sortProperties: ['name']
  sortAscending: true
  rescoreMessage: 'Re-score Stories'
  add_feed: ->
    url = Ember.$('#add_feed').val()
    new_feed = @store.createRecord 'feed', {feed_url: url, name: 'temp'}
    new_feed.save()
  showFeeds: true
  unreadCount: Ember.computed '@each.unread_count', ->
    @model.reduce (prev, feed) ->
      prev + feed.get('unread_count')
    , 0

  actions:
    toggleShowRead: ->
      @set 'controllers.application.showRead', !@get('controllers.application.showRead')
      false


    cycleSort: ->
      @set 'controllers.application.storySort', @get('controllers.application.nextSort')
      @get('controllers.stories').send 'resetFocus', true

    toggleSidebar: ->
      @set 'showFeeds', !@get('showFeeds')

    recomputeScores: ->
      @set('rescoreMessage', 'Working on it...')
      Ember.$.post('recompute_scores')

`export default C`
