`import Ember from 'ember'`
`import NextPrev from 'feed-ember/mixins/next_prev'`
`import Paginates from 'feed-ember/mixins/paginates'`

C = Ember.ArrayController.extend NextPrev, Paginates,
  needs: ['application']
  #sortProperties: Ember.computed.alias 'controllers.application.sortMethod'
  sortFunction: Ember.computed.alias 'controllers.application.sortFunction'

  sortAscending: false

  showReadStories: Ember.computed 'showRead', ->
    su = @get 'showRead'
    if su == undefined
      @set 'showRead', true
      true
    else
      su

  filteredContent: Ember.computed '@each.read', ->
    if @get('showRead')
      @get('content')
    else
      @get('content').filter (story) ->
        story.get('read') == false


  unreadStories: Ember.computed '@each.read', ->
    @get('pagedContent').filter (story) ->
      story.get('read') == false

  actions:
    toggleShowRead: ->
      su = @get 'showRead'
      if su == undefined || su == true
        @set 'showRead', false
      else
        @set 'showRead', true
      null

    toggleRead: (id) ->
      @store.find('story',id).then (s) ->
        s.set 'read', !s.get('read')
        s.save()

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

    cycleSort: ->
      @set('controllers.application.storySort', @get('controllers.application.nextSort'))
      @send('resetFocus', true)

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
