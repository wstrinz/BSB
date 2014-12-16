`import Ember from 'ember'`
`import NextPrev from 'feed-ember/mixins/next_prev'`
`import Paginates from 'feed-ember/mixins/paginates'`
`import ReadUnreadMixin from 'feed-ember/mixins/read-unread'`

C = Ember.ArrayController.extend NextPrev, Paginates, ReadUnreadMixin,
  needs: ['application']
  #sortProperties: Ember.computed.alias 'controllers.application.sortMethod'
  sortFunction: Ember.computed.alias 'controllers.application.sortFunction'

  sortAscending: false

  filteredContent: Ember.computed '@each.read', ->
    if @get('showRead')
      @get('content')
    else
      @get('content').filter (story) ->
        story.get('read') == false

  actions:
    resetFocus: (force) ->
      model = @get('model')
      sortMethod = @get 'controllers.application.storySort'
      current = @get('focusedStory')

      stories = model.sortBy(sortMethod).reverse()

      unless @get('showRead')
        stories = stories.filter((m) -> m.get('read') == false)

      target = stories[0]
      if target && (force || !@get('focusedStory'))
        if current
          current.set('focused', false)
        target.set('focused', true)
        @set('focusedStory', target)

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
