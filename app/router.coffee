`import Ember from 'ember'`

Router = Ember.Router.extend
  location: FeedEmberENV.locationType

Router.map(->
  @resource('feeds', ->
    @route 'stories', { path: '/:feed_id' })

  @resource('stories', ->
    @route 'show', { path: '/:story_id' }))

`export default Router`
