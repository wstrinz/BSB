`import Ember from 'ember'`
`import ApplicationRoute from 'ember'`

HelpController = Ember.Controller.extend
  needs: ['application']

  built_in_shortcuts: Ember.computed ->
    shortcuts = @container.lookup('route:application').shortcuts
    keys = Object.keys(shortcuts)
    keys.pop()
    keys.map( (k) -> [k, shortcuts[k]])

  user_shortcuts: Ember.computed ->
    @store.find('shortcut')

`export default HelpController`
