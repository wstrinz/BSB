`import Ember from 'ember'`

R = Ember.Route.extend
  model: (params) ->
    appcon = @controllerFor('application')
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
      @controller.send('viewItem')
      @controller.send('toggleCurrentRead')
    toggleShowInIframe: ->
      c = @controllerFor('application')
      c.set 'showInIframe', !c.get('showInIframe')
    toggleSandboxIframe: -> @set 'sandboxIframe', !@get('sandboxIframe')

`export default R`
