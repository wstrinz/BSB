`import Ember from 'ember'`

Router = Ember.Router.extend
  location: FeedEmberENV.locationType

Router.map ->
  @route 'feeds'
  @resource 'feed', { path: '/feeds/:feed_id' }, ->
    @resource 'story', { path: '/stories/:story_id' }

  #@route 'all'
  #@resource 'feeds', ->
    #@resource 'feed', { path: '/:feed_id' }, ->
      #@route 'story'

  #@resource('stories', ->
    #@route 'show', { path: '/:story_id' })

`export default Router`
