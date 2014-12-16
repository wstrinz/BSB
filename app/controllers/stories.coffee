`import Ember from 'ember'`
`import NextPrev from 'feed-ember/mixins/next_prev'`
`import Paginates from 'feed-ember/mixins/paginates'`
`import ReadUnreadMixin from 'feed-ember/mixins/read-unread'`

C = Ember.ArrayController.extend NextPrev, Paginates, ReadUnreadMixin,
  needs: ['application']
  sortProperties: Ember.computed.alias 'controllers.application.sortMethod'
  sortAscending: false
  storySort: Ember.computed.alias 'controllers.application.storySort'
  model_feed: Ember.computed.alias 'model.firstObject.feed'
  feed_title: Ember.computed.alias 'model.firstObject.feed.name'
  feed_url: Ember.computed.alias 'model.firstObject.feed.feed_url'

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

`export default C`
