`import Ember from 'ember'`

R = Ember.Route.extend
  model: (params) -> @store.find('feed', params.feed_id).then(
    (f) -> f.get('stories'))

`export default R`
