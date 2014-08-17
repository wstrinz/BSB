`import Ember from 'ember'`

R = Ember.Route.extend
  model: -> @store.find('story').then((s) -> s)

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.send 'resetFocus', false

  actions:
    nextItem: -> @controller.send('nextItem')
    prevItem: -> @controller.send('prevItem')
    viewItem: -> @controller.send('viewItem')
    toggleCurrentRead: -> @controller.send('toggleCurrentRead')

`export default R`
