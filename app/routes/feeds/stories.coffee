`import Ember from 'ember'`

R = Ember.Route.extend
  model: (params) -> @store.find('feed', params.feed_id).then(
    (f) -> f.get('stories'))

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.send 'resetFocus', false

  shortcuts:
    'z': 'prevStory'
    'x': 'nextStory'
    'v': 'toggleRead'
    'c': 'readStory'

  currentStory: Ember.computed 'controller.focusedStory', ->
    current = @controller.get('focusedStory')

    unless current
      current = @controller.get('model').find((m) -> m.get('focused'))
      @controller.set('focusedStory', current)

    current

  storyAt: (offset) ->
    current = @get('currentStory')
    model = @controller.get 'model'
    sortMethod = @controller.get('storySort')
    showRead = @controller.get 'showReadStories'

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
    prevStory: ->
      prev = @storyAt -1
      prev.set 'focused', true
      @get('currentStory').set 'focused', false
      @controller.set 'focusedStory', prev

    nextStory: ->
      next = @storyAt 1
      next.set 'focused', true
      @get('currentStory').set 'focused', false
      @controller.set 'focusedStory', next

    readStory: ->
      current = @get 'currentStory'
      model = @controller.get 'model'

      @send('nextStory')
      @transitionTo 'stories.show', current.get('id')

    toggleRead: ->
      current = @get 'currentStory'
      model = @controller.get 'model'

      if current.get('read')
        current.set('read', false)
      else
        current.set('read', true)

      current.save()
      @send('nextStory')

`export default R`
