`import Ember from 'ember'`

M = Ember.Mixin.create
  storyAt: (offset) ->
    current = @get 'currentStory'
    model_content = @get 'model.arrangedContent.content'
    sortMethod = @get 'controllers.application.storySort'
    showRead = @get 'showReadStories'

    unless showRead
      model_content = model_content.filter (c) -> c.get('read') == false

    i = model_content.indexOf(current)
    length = model_content.length
    model_content[i + offset]

  currentStory: Ember.computed 'focusedStory', ->
    current = @get('focusedStory')

    unless current
      current = @get('model').find((m) -> m.get('focused'))
      @set('focusedStory', current)

    current

  actions:
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

    focusStory: (story) ->
      @get('currentStory').set('focused', false)
      @set('focusedStory', story)
      story.set('focused', true)

    toggleFocus: (story) ->
      current = @get('currentStory')
      if current && current != story
        current.set('focused', false)

      if story.get('focused')
        story.set('focused', false)
        @set('focusedStory', null)
      else
        story.set('focused', true)
        @set('focusedStory', story)

    openIfFocused: (story) ->
      if story.get('focused')
        window.open(story.get('url'))

    resetFocus: (force) ->
      return false
      model = @get 'model'
      current = @get 'focusedStory'

      stories = model.sortBy(@get 'storySort').reverse()

      unless @get 'showRead'
        stories = stories.filter((m) -> m.get('read') == false)

      currentFeed = model.content[0].get 'feed.id'
      target = stories[0]
      if target && (force || (!@get('focusedStory') || @get('feed') != currentFeed))
        if current
          current.set('focused', false)
        target.set('focused', true)
        @set('feed', currentFeed)
        @set('focusedStory', target)
`export default M`
