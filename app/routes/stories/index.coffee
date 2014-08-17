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

    reload: ->
      appcon = @controllerFor('application')
      model = @controller.get('model')

      @store.find('story',
        read: appcon.get('showRead'),
        sort: appcon.get('storySort'),
        page: @controller.get('page')
      ).then((s) -> model.addObjects(s))

`export default R`
