`import Ember from 'ember'`

Router = Ember.Router.extend
  location: FeedEmberENV.locationType

Router.map ->
  @resource 'feeds', ->
    @resource 'stories', { path: '/:feed_id' }, ->
      @route 'story'
    @route 'all'
    @route 'edit', { path: '/:feed_id/edit' }

  #@resource('stories', ->
    #@route 'show', { path: '/:story_id' })
  @route 'shortcuts'
  @route 'settings'

`export default Router`
