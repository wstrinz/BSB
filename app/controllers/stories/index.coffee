`import Ember from 'ember'`

C = Ember.ArrayController.extend
  needs: ['application']
  sortProperties: Ember.computed.alias 'controllers.application.sortMethod'
  sortAscending: false,

  currentStory: Ember.computed 'focusedStory', ->
    current = @get('focusedStory')

    unless current
      current = @get('model').find((m) -> m.get('focused'))
      @set('focusedStory', current)

    current

  showReadStories: Ember.computed 'showRead', ->
    su = @get 'showRead'
    if su == undefined
      @set 'showRead', false
      false
    else
      su

  unreadStories: Ember.computed '@each.read', ->
    @filter (story) ->
      story.get('read') == false

  storyAt: (offset) ->
    current = @get 'currentStory'
    model = @get 'model'
    sortMethod = @get 'controllers.application.storySort'
    showRead = @get 'showReadStories'

    stories = model.filter((s) ->
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


  actions:
    toggleShowRead: ->
      su = @get 'showRead'
      if su == undefined || su == true
        @set 'showRead', false
      else
        @set 'showRead', true
      null

    toggleRead: (id) ->
      @store.find('story',id).then((s) ->
        if s.get('read')
          s.set 'read', false
        else
          s.set 'read', true
        s.save())

    resetFocus: (force) ->
      model = @get('model')
      sortMethod = @get 'controllers.application.storySort'
      current = @get('focusedStory')

      stories = model.sortBy(sortMethod).reverse()

      unless @get('showRead')
        stories = stories.filter((m) -> m.get('read') == false)

      target = stories[0]
      if target && force || !@get('focusedStory')
        if current
          current.set('focused', false)
        target.set('focused', true)
        @set('focusedStory', target)

    nextItem: ->
      next = @storyAt(1)
      if next
        @get('currentStory').set('focused', false)
        @set('focusedStory', next)
        next.set('focused', true)

    prevItem: ->
      prev = @storyAt(-1)
      if prev
        @get('currentStory').set('focused', false)
        @set('focusedStory', prev)
        prev.set('focused', true)



`export default C`
