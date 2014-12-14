`import Ember from 'ember'`

ShortcutsRoute = Ember.Route.extend
  model: -> @store.find('shortcut')

  setupController: (controller, model) ->
    controller.set('model', model)
    controller.shortcuts.disable()

`export default ShortcutsRoute`
