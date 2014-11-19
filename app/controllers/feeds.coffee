`import Ember from 'ember'`

C = Ember.ArrayController.extend
  needs: ['application', 'stories']
  sortProperties: ['name']
  sortAscending: true
  rescoreMessage: 'Re-score Stories'
  add_feed: ->
    url = Ember.$('#add_feed').val()
    new_feed = @store.createRecord 'feed', {feed_url: url, name: 'temp'}
    new_feed.save()
  showFeeds: false
  isRecomputing: false
  recomputeStatus: "idle"
  unreadCount: Ember.computed '@each.unread_count', ->
    @model.reduce (prev, feed) ->
      prev + feed.get('unread_count')
    , 0

  actions:
    toggleShowRead: ->
      @set 'controllers.application.showRead', !@get('controllers.application.showRead')
      false

    cycleSort: ->
      @set 'controllers.application.storySort', @get('controllers.application.nextSort')
      @get('controllers.stories').send 'resetFocus', true

    toggleSidebar: ->
      @set 'showFeeds', !@get('showFeeds')

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

`export default C`
