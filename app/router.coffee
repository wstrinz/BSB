`import Ember from 'ember'`

Router = Ember.Router.extend
  location: FeedEmberENV.locationType

Router.map ->
  @resource 'feeds', ->
    @resource 'stories', { path: '/:feed_id' }, ->
      @route 'story'
    @route 'all'

  #@resource('stories', ->
    #@route 'show', { path: '/:story_id' })

`export default Router`
