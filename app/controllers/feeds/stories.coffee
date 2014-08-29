`import Ember from 'ember'`
`import NextPrev from 'feed-ember/mixins/next_prev'`

C = Ember.ArrayController.extend NextPrev,
  needs: ['application']
  sortProperties: Ember.computed.alias 'controllers.application.sortMethod'
  sortAscending: false
  storySort: Ember.computed.alias 'controllers.application.storySort'
  feed: Ember.computed 'model', -> @get('model').content[0].get('feed')

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
    toggleShowRead: ->
      su = @get 'showRead'
      if su == undefined || su == true
        @set 'showRead', false
      else
        @set 'showRead', true
      null

    cycleSort: ->
      @set 'controllers.application.storySort', @get('controllers.application.nextSort')
      @send 'resetFocus', true


    #nextItem: ->
      #next = @storyAt 1
      #if next
        #next.set 'focused', true
        #@get('currentStory').set 'focused', false
        #@set 'focusedStory', next

    #prevItem: ->
      #prev = @storyAt -1
      #if prev
        #prev.set 'focused', true
        #@get('currentStory').set 'focused', false
        #@set 'focusedStory', prev

    viewItem: ->
      current = @get 'currentStory'

      @send 'nextItem'
      @transitionToRoute 'feeds.story', current.get('id')

    toggleCurrentRead: ->
      current = @get 'currentStory'

      if current.get('read')
        current.set('read', false)
      else
        current.set('read', true)

      current.save()
      @send 'nextItem'

`export default C`
