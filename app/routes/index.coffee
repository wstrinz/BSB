`import Ember from 'ember'`

R = Ember.Route.extend
  redirect: ->
    @transitionTo 'feeds.all'

`export default R`
