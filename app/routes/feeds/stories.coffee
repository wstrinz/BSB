`import Ember from 'ember'`

R = Ember.Route.extend
  model: (params) -> @store.find('feed', params.feed_id).then(
    (f) -> f.get('stories'))

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.send 'resetFocus', false

  actions:
    prevItem: -> @controller.send('prevItem')
    nextItem: -> @controller.send('nextItem')
    viewItem: -> @controller.send('viewItem')
    toggleCurrentRead: -> @controller.send('toggleCurrentRead')

`export default R`
