`import Ember from 'ember'`

R = Ember.Route.extend
  model: (params) ->
    @store.find('story', params.story_id)

  afterModel: (story) ->
    story.set 'read', true
    story.save()
    null

  actions:
    markUnread: ->
      mod = @controller.get 'model'
      mod.set 'read', false
      mod.save()
      @transitionTo 'feeds.stories', mod.get('feed').get('id')

`export default R`
