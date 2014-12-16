`import Ember from 'ember'`
`import RouteNextPrevMixin from 'feed-ember/mixins/route-next-prev'`

module 'RouteNextPrevMixin'

# Replace this with your real tests.
test 'it works', ->
  RouteNextPrevObject = Ember.Object.extend RouteNextPrevMixin
  subject = RouteNextPrevObject.create()
  ok subject
