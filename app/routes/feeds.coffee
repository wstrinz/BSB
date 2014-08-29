`import Ember from 'ember'`

R = Ember.Route.extend
  model: -> @store.find('feed')

`export default R`
