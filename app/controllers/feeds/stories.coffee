`import Ember from 'ember'`

C = Ember.ArrayController.extend
  needs: ['application']
  sortProperties: Ember.computed.alias 'controllers.application.sortMethod'
  sortAscending: false
  storySort: Ember.computed.alias 'controllers.application.storySort'

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
      sortMethod = @get('storySort')
      current = @get('focusedStory')

      stories = model.sortBy(sortMethod).reverse()

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

`export default C`
