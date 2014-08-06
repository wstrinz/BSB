`import Ember from 'ember'`

R = Ember.Route.extend
  model: -> @store.find('story').then((s) -> s)

`export default R`
