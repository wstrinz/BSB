`import Ember from 'ember'`

R = Ember.Route.extend
  model: ->
    appcon = @controllerFor('application')
    @store.find 'story', read: appcon.get('showRead'), sort: appcon.get('storySort')

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.send 'resetFocus', false

  actions:
    nextItem: -> @controller.send('nextItem')
    prevItem: -> @controller.send('prevItem')
    viewItem: -> @controller.send('viewItem')
    toggleCurrentRead: -> @controller.send('toggleCurrentRead')
    viewAndMarkItem: ->
      @controller.send('viewInBackground')
      @controller.send('toggleCurrentRead')

    toggleShowInIframe: ->
      c = @controllerFor('application')
      c.set 'showInIframe', !c.get('showInIframe')

    reload: ->
      appcon = @controllerFor('application')
      model = @controller.get('model')

      @store.find('story',
        read: appcon.get('showRead'),
        sort: appcon.get('storySort'),
        page: @controller.get('page')
      ).then (stories) ->
        ids = model.mapProperty('id')
        stories = stories.reject (s) -> ids.contains(s.get 'id')
        model.addObjects(stories)

`export default R`
