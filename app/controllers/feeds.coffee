`import Ember from 'ember'`

C = Ember.ArrayController.extend
  needs: ['application', 'stories']
  sortProperties: ['name']
  sortAscending: true
  showFeeds: false
  unreadCount: Ember.computed '@each.unread_count', ->
    @model.reduce (prev, feed) ->
      prev + feed.get('unread_count')
    , 0

  actions:
    toggleSidebar: ->
      @set 'showFeeds', !@get('showFeeds')

`export default C`
