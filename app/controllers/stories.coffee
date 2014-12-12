`import Ember from 'ember'`
`import NextPrev from 'feed-ember/mixins/next_prev'`
`import Paginates from 'feed-ember/mixins/paginates'`

C = Ember.ArrayController.extend NextPrev, Paginates,
  needs: ['application']
  sortProperties: Ember.computed.alias 'controllers.application.sortMethod'
  sortAscending: false
  storySort: Ember.computed.alias 'controllers.application.storySort'
  model_feed: Ember.computed.alias 'model.firstObject.feed'
  showRead: Ember.computed.alias 'controllers.application.showRead'
  feed_title: Ember.computed.alias 'model.firstObject.feed.name'
  feed_url: Ember.computed.alias 'model.firstObject.feed.feed_url'

  showReadStories: Ember.computed 'showRead', ->
    @get 'showRead'

  unreadStories: Ember.computed '@each.read', ->
    @filter (story) -> story.get('read') == false

  storyCount: Ember.computed '@each.read', 'showRead', 'feed', ->
    if @get 'showRead'
      @length
    else
      @get('feed').unread_count

  filteredContent: Ember.computed '@each.read', ->
    if @get('showRead')
      @get('content')
    else
      @get('content').filter (story) ->
        story.get('read') == false

  actions:
    viewItem: ->
      current = @get 'currentStory'

      window.open current.get('url'), '_blank'

    viewInBackground: ->
      current = @get 'currentStory'

      a = document.createElement("a")
      a.href = current.get('url')
      evt = document.createEvent("MouseEvents")

      evt.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0,
                                true, false, false, true, 0, null)
      a.dispatchEvent(evt)
      false

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

`export default C`
