`import Ember from 'ember'`

C = Ember.ArrayController.extend
  needs: ['application']
  sortProperties: Ember.computed.alias 'controllers.application.sortMethod'
  sortAscending: false,
  page: 1

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
    ## this still doesn't take showRead into account
    current = @get 'currentStory'
    model_content = @get 'model.arrangedContent'
    sortMethod = @get 'controllers.application.storySort'
    showRead = @get 'showReadStories'

    unless showRead
      model_content = model_content.filter (c) -> c.get('read') == false

    i = model_content.indexOf(current)
    length = model_content.length
    model_content[i + offset]

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
        s.set 'marking', Ember.run.later(this, ->
          s.set 'read', !s.get('read')
          s.save()
          s.set 'marking', null
          alert('donemark')
        , 1000)
      )

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

    viewItem: ->
      current = @get 'currentStory'

      @send 'nextItem'
      @transitionToRoute 'stories.show', current.get('id')

    cycleSort: ->
      @set('controllers.application.storySort', @get('controllers.application.nextSort'))
      @send('resetFocus', true)

    toggleCurrentRead: ->
      current = @get 'currentStory'
      if current.get 'marking'
        Ember.run.cancel current.get('marking')
      else
        current.set 'marking', Ember.run.later(this, ->
          current.set 'read', !current.get('read')
          current.save()
          current.set 'marking', null
        , 3500)

      @send 'nextItem'

    loadNextPage: ->
      @set('page', @get('page') + 1)
      @send('reload')

`export default C`
