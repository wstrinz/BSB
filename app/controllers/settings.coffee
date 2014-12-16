`import Ember from 'ember'`

SettingsController = Ember.Controller.extend
  needs: ['application']

  rescoreMessage: 'Re-score Stories'
  isRecomputing: false
  recomputeStatus: "idle"

  actions:
    toggleShowRead: ->
      @set 'controllers.application.showRead', !@get('controllers.application.showRead')
      false

    add_feed: ->
      url = Ember.$('#add_feed').val()
      new_feed = @store.createRecord 'feed', {feed_url: url, name: 'temp'}
      new_feed.save()

    cycleSort: ->
      @set 'controllers.application.storySort', @get('controllers.application.nextSort')
      @get('controllers.stories').send 'resetFocus', true

    recomputeScores: ->
      @set('isRecomputing', true)
      @set('recomputeStatus', 'starting')
      Ember.$.post('recompute_scores')
      @send('pollForRecomputeStatus')

    pollForRecomputeStatus: ->
      me = this
      succ = (resp) ->
        me.set('recomputeStatus', resp.status)
        if resp.status == "no job running"
          null
        else if resp.status == "done"
          me.set('isRecomputing', false)
        else
          Ember.run.later(->
            Ember.$.get('recompute_status', succ)
          , 1000)

      Ember.run.later(->
        Ember.$.get('recompute_status', succ)
      , 1000)

`export default SettingsController`
