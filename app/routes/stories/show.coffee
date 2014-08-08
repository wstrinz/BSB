`import Ember from 'ember'`

R = Ember.Route.extend
  model: (params) ->
    @store.find('story', params.story_id)

  afterModel: (story) ->
    story.set 'read', true
    story.save()
    null

  shortcuts:
    'u': 'markUnread'
    'j': 'nextStory'
    'k': 'prevStory'
    'shift+a': 'loggy'

  actions:
    markUnread: ->
      mod = @controller.get 'model'
      mod.set 'read', false
      mod.save()
      @transitionTo 'feeds.stories', mod.get('feed').get('id')

    nextStory: ->
      model = @controller.get 'model'
      id = parseInt(model.get('id'))
      r = this
      model.get('feed').get('stories').then((stories) ->
        nextStories = stories.filter((s) ->
          s.get('read') == false && parseInt(s.get('id')) < id)

        nextId = nextStories[nextStories.length - 1].get('id')
        r.transitionTo('stories.show', nextId)
      )

    prevStory: ->
      model = @controller.get 'model'
      id = parseInt(model.get('id'))
      r = this
      model.get('feed').get('stories').then((stories) ->
        nextStories = stories.filter (s) ->
          s.get('read') == false && parseInt(s.get('id')) > id

        nextId = nextStories[0].get('id')
        r.transitionTo('stories.show', nextId)
      )

`export default R`
