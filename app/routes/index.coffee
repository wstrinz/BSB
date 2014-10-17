`import Ember from 'ember'`

R = Ember.Route.extend
  redirect: ->
   @transitionTo 'feeds'

`export default R`
