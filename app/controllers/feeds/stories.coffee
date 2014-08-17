`import Ember from 'ember'`

C = Ember.ArrayController.extend
  needs: ['application']
  sortProperties: Ember.computed.alias 'controllers.application.sortMethod'
  sortAscending: false
  storySort: Ember.computed.alias 'controllers.application.storySort'

  currentStory: Ember.computed 'focusedStory', ->
    current = @get('focusedStory')

    unless current
      current = @get('model').find((m) -> m.get('focused'))
      @set('focusedStory', current)

    current

  storyAt: (offset) ->
    current = @get('currentStory')
    sortMethod = @get('storySort')
    showRead = @get 'showReadStories'

    stories = @get('model').filter((s) ->
      incl = true
      unless showRead
        incl = incl && !s.get('read')

      if offset > 0
         incl = incl && s.get(sortMethod) < current.get(sortMethod)
      else
         incl = incl && s.get(sortMethod) > current.get(sortMethod)

      incl
    ).sortBy(sortMethod).reverse()

    if offset > 0
      stories[offset - 1]
    else
      stories[stories.length + offset]

  showReadStories: Ember.computed 'showRead', ->
    su = @get 'showRead'
    if su == undefined
      @set('showRead', false)
      false
    else
      su

  unreadStories: Ember.computed '@each.read', ->
    @filter (story) ->
      story.get('read') == false

  storyCount: Ember.computed '@each.read', 'showRead', ->
    if @get('showRead')
      this.length
    else
      @get('unreadStories').length

  actions:
    toggleShowRead: ->
      su = @get 'showRead'
      if su == undefined || su == true
        @set('showRead', false)
      else
        @set('showRead', true)
      null

    cycleSort: ->
      @set('controllers.application.storySort', @get('controllers.application.nextSort'))
      @send('resetFocus', true)

    resetFocus: (force) ->
      model = @get('model')
      current = @get('focusedStory')

      stories = model.sortBy(@get('storySort')).reverse()

      unless @get('showRead')
        stories = stories.filter((m) -> m.get('read') == false)

      currentFeed = model.content[0].get('feed.id')
      target = stories[0]
      if target && force || (!@get('focusedStory') || @get('feed') != currentFeed)
        if current
          current.set('focused', false)
        target.set('focused', true)
        @set('feed', currentFeed)
        @set('focusedStory', target)

    nextItem: ->
      next = @storyAt 1
      if next
        next.set 'focused', true
        @get('currentStory').set 'focused', false
        @set 'focusedStory', next

    prevItem: ->
      prev = @storyAt -1
      if prev
        prev.set 'focused', true
        @get('currentStory').set 'focused', false
        @set 'focusedStory', prev

    viewItem: ->
      current = @get 'currentStory'

      @send 'nextItem'
      @transitionToRoute 'stories.show', current.get('id')

    toggleCurrentRead: ->
      current = @get 'currentStory'

      if current.get('read')
        current.set('read', false)
      else
        current.set('read', true)

      current.save()
      @send 'nextItem'

`export default C`
