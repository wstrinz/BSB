`import Ember from 'ember'`

R = Ember.Route.extend
  model: (params) ->
    @store.find('story', params.story_id)

  afterModel: (story) ->
    story.set 'read', true
    story.save()
    null

  shortcuts:
    'p': 'toggleShowInIframe'
    'u': 'toggleRead'
    'j': 'nextStory'
    'k': 'prevStory'
    's': 'toggleSandboxIframe'
    'f': 'backToFeed'

  actions:
    toggleRead: ->
      mod = @controller.get 'model'
      if mod.get 'read'
        mod.set 'read', false
      else
        mod.set 'read', true

      mod.save()

    nextStory: ->
      model = @controller.get 'model'
      t = model.get('timestamp')
      r = this
      model.get('feed.stories').then((stories) ->
        nextStories = stories.filter (s) ->
          s.get('read') == false && s.get('timestamp') < t
        
        nextId = nextStories[0].get('id')
        r.transitionTo('stories.show', nextId)
      )

    prevStory: ->
      model = @controller.get 'model'
      t = model.get('timestamp')
      r = this
      model.get('feed.stories').then((stories) ->
        prevStories = stories.filter (s) ->
          s.get('read') == false && s.get('timestamp') > t
        
        prevId = prevStories[prevStories.length - 1].get('id')
        r.transitionTo('stories.show', prevId)
      )

    toggleShowInIframe: ->
      if @controller.get('showInIframe')
        @controller.set('showInIframe', false)
      else
        @controller.set('showInIframe', true)

    toggleSandboxIframe: ->
      if @controller.get('sandboxIframe')
        @controller.set('sandboxIframe', false)
      else
        @controller.set('sandboxIframe', true)

    backToFeed: ->
      id = @controller.get('model').get('feed').get('id')
      @transitionTo('feeds.stories', id)

`export default R`
