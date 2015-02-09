`import Ember from 'ember'`
`import config from './config/environment';`

Router = Ember.Router.extend
  location: config.locationType

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
  @route 'help'

`export default Router`
