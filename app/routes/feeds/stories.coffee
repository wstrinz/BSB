`import Ember from 'ember'`

R = Ember.Route.extend
  model: (params) -> @store.find('feed', params.feed_id).then(
    (f) -> f.get('stories'))

  setupController: (controller, model) ->
    controller.set('model', model)
    unread = model.filter((m) -> m.get('read') == false).sortBy('timestamp')
    if unread[0] && !controller.get('focusedStory')
      unread[0].set('focused', true)
      controller.set('focusedStory', unread[0])

  shortcuts:
    'z': 'prevStory'
    'x': 'nextStory'
    'v': 'toggleRead'
    'c': 'readStory'

  actions:
    prevStory: ->
      current = @controller.get('focusedStory')
      model = @controller.get 'model'

      unless current
        current = model.find((m) -> m.get('focused'))
        @controller.set('focusedStory', current)

      prevStories = model.filter((s) ->
        s.get('read') == false && s.get('timestamp') < current.get('timestamp')
      ).sortBy('timestamp')

      prev = prevStories[prevStories.length - 1]
      prev.set 'focused', true
      current.set 'focused', false
      @controller.set 'focusedStory', prev

    nextStory: ->
      current = @controller.get('focusedStory')
      model = @controller.get 'model'

      unless current
        current = model.find((m) -> m.get('focused'))
        @controller.set('focusedStory', current)

      nextStories = model.filter((s) ->
        s.get('read') == false && s.get('timestamp') > current.get('timestamp')
      ).sortBy('timestamp')

      next = nextStories[0]
      next.set 'focused', true
      current.set 'focused', false
      @controller.set 'focusedStory', next

    readStory: ->
      current = @controller.get 'focusedStory'
      model = @controller.get 'model'

      unless current
        current = model.find (m) -> m.get('focused')
        @controller.set('focusedStory', current)

      @send('nextStory')
      @transitionTo 'stories.show', current.get('id')

    toggleRead: ->
      current = @controller.get 'focusedStory'
      model = @controller.get 'model'

      unless current
        current = model.find (m) -> m.get('focused')
        @controller.set('focusedStory', current)

      if current.get('read')
        current.set('read', false)
      else
        current.set('read', true)

      current.save()
      @send('nextStory')

`export default R`
