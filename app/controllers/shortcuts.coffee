`import Ember from 'ember'`

ShortcutsController = Ember.Controller.extend
  actions:
    addShortcut: ->
      key = Ember.$('#new_key').val()
      action = Ember.$('#new_action').val()
      new_shortcut = @store.createRecord 'shortcut', {key: key, action: action}
      new_shortcut.save()
      key = Ember.$('#new_key').val('')
      action = Ember.$('#new_action').val('')

    updateShortcuts: ->
      m = @get('model')
      m.forEach( ((s) -> s.save()), m.content)

    deleteShortcut: (shortcut) ->
      shortcut.deleteRecord()
      shortcut.save()

`export default ShortcutsController`
