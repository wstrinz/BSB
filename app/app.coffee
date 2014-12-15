`import Ember from 'ember'`
`import Resolver from 'ember/resolver'`
`import loadInitializers from 'ember/load-initializers'`
`import Notify from 'ember-notify'`

Ember.MODEL_FACTORY_INJECTIONS = true
Notify.useBootstrap()

App = Ember.Application.extend
  modulePrefix: 'feed-ember',  # TODO: loaded via config
  Resolver: Resolver

loadInitializers App, 'feed-ember'

`export default App`
