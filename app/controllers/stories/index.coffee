`import Ember from 'ember'`

C = Ember.ArrayController.extend
  sortProperties: ['timestamp'],
  sortAscending: false,
  actions:
    toggleShowRead: ->
      su = @get 'showRead'
      if su == undefined || su == true
        @set 'showRead', false
      else
        @set 'showRead', true
      null

    toggleRead: (id) ->
      @store.find('story',id).then((s) ->
        if s.get('read')
          s.set 'read', false
        else
          s.set 'read', true
        s.save())

  showReadStories: Ember.computed 'showRead', ->
    su = @get 'showRead'
    if su == undefined
      @set 'showRead', false
      false
    else
      su

  unreadStories: Ember.computed '@each.read', ->
    @filter (story) ->
      story.get('read') == false

`export default C`
