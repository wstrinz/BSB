`import Ember from 'ember'`

FeedsEditRoute = Ember.Route.extend
  model: (params)-> @store.find('feed', params.feed_id)

`export default FeedsEditRoute`
