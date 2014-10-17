`import Ember from 'ember'`

R = Ember.Route.extend
  model: (params) ->
    appcon = @controllerFor('application')
    @set('feed_id', params.feed_id)
    @store.find 'story',
      feed_id: params.feed_id
      read: appcon.get('showRead')
      sort: appcon.get('storySort')

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.send 'resetFocus', false

  actions:
    prevItem: -> @controller.send('prevItem')
    nextItem: -> @controller.send('nextItem')
    viewItem: -> @controller.send('viewItem')
    toggleCurrentRead: -> @controller.send('toggleCurrentRead')
    viewAndMarkItem: ->
      @controller.send('viewInBackground')
      @controller.send('toggleCurrentRead')
    toggleShowInIframe: ->
      c = @controllerFor('application')
      c.set 'showInIframe', !c.get('showInIframe')
    toggleSandboxIframe: -> @set 'sandboxIframe', !@get('sandboxIframe')

    reload: ->
      appcon = @controllerFor('application')
      model = @controller.get('model')

      @store.find('story',
        feed_id: @get('feed_id'),
        read: appcon.get('showRead'),
        sort: appcon.get('storySort'),
        page: @controller.get('page')
      ).then (stories) ->
        ids = model.mapProperty('id')
        stories = stories.reject (s) -> ids.contains(s.get 'id')
        model.addObjects(stories)

`export default R`
