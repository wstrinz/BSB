`import Ember from 'ember'`
`import NextPrev from 'feed-ember/mixins/next_prev'`

C = Ember.ArrayController.extend NextPrev,
  needs: ['application']
  sortProperties: Ember.computed.alias 'controllers.application.sortMethod'
  sortAscending: false
  storySort: Ember.computed.alias 'controllers.application.storySort'
  feed: Ember.computed 'model', -> @get('model').content[0].get('feed')
  showRead: Ember.computed.alias 'controllers.application.showRead'

  showReadStories: Ember.computed 'showRead', ->
    su = @get 'showRead'
    if su == undefined
      @set 'showRead', false
      false
    else
      su

  unreadStories: Ember.computed '@each.read', ->
    @filter (story) -> story.get('read') == false

  storyCount: Ember.computed '@each.read', 'showRead', 'feed', ->
    if @get 'showRead'
      @length
    else
      @get('feed').unread_count

  actions:
    viewItem: ->
      current = @get 'currentStory'

      @send 'nextItem'
      window.open current.get('url'), '_blank'

    toggleCurrentRead: ->
      current = @get 'currentStory'
      if current.get 'marking'
        Ember.run.cancel current.get('marking')
      else
        current.set 'marking', Ember.run.later(this, ->
          current.set 'read', !current.get('read')
          current.save()
          current.set 'marking', null
        , 3500)

      @send 'nextItem'

`export default C`
