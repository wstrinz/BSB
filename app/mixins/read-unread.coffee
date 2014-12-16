`import Ember from 'ember'`

ReadUnreadMixin = Ember.Mixin.create
  showRead: Ember.computed.alias 'controllers.application.showRead'
  showReadStories: Ember.computed.alias 'showRead'

  unreadStories: Ember.computed '@each.read', ->
    @get('pagedContent').filter (story) ->
      story.get('read') == false

  actions:
    toggleShowRead: -> @set 'showRead', !@get('showRead')

    toggleRead: (id) ->
      @store.find('story',id).then (s) ->
        s.set 'read', !s.get('read')
        s.save()

    toggleCurrentRead: ->
      current = @get 'currentStory'

      if current.get('read')
        change = 1
      else
        change = -1

      current.set 'read', !current.get('read')
      current.save()
      current.get('feed').set('unread_count', current.get('feed.unread_count') + change)
      @send 'nextItem'


`export default ReadUnreadMixin`
