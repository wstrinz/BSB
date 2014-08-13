`import Ember from 'ember'`

C = Ember.ArrayController.extend
  sortProperties: ['timestamp', 'id']
  sortAscending: false

  actions:
    toggleShowRead: ->
      su = @get 'showRead'
      if su == undefined || su == true
        @set('showRead', false)
      else
        @set('showRead', true)
      null

  showReadStories: Ember.computed 'showRead', ->
    su = @get 'showRead'
    if su == undefined
      @set('showRead', false)
      false
    else
      su

  unreadStories: Ember.computed '@each.read', ->
    @filter (story) ->
      story.get('read') == false

  storyCount: Ember.computed '@each.read', 'showRead' ->
    if @get('showRead')
      this.length
    else
      @get('unreadStories').length


`export default C`
