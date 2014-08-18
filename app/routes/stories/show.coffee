`import Ember from 'ember'`

R = Ember.Route.extend
  model: (params) ->
    @store.find('story', params.story_id)

  afterModel: (story) ->
    story.set 'read', true
    story.save()
    null

  storyAt: (offset) ->
    model = @controller.get 'model'
    sortMethod = @controllerFor('application').get 'storySort'
    showRead = @controller.get 'showReadStories'
    comp = model.get(sortMethod)
    feed_stories = model.get('feed.stories')

    stories = feed_stories.then((st) ->
      st.filter((s) ->
        incl = true
        unless showRead
          incl = incl && !s.get('read')

        if offset > 0
          incl = incl && s.get(sortMethod) < comp
        else
          incl = incl && s.get(sortMethod) > comp

        incl
      ).sortBy(sortMethod).reverse())

    stories.then (s) ->
      if offset > 0
        s[offset - 1]
      else
        s[s.length + offset]

  shortcuts:
    'p': 'toggleShowInIframe'
    's': 'toggleSandboxIframe'

  actions:
    toggleRead: ->
      mod = @controller.get 'model'
      if mod.get 'read'
        mod.set 'read', false
      else
        mod.set 'read', true

      mod.save()

    nextItem: ->
      r = this
      @storyAt(1).then (s) ->
        r.transitionTo 'stories.show', s.get('id')

    prevItem: ->
      r = this
      @storyAt(-1).then (s) ->
        r.transitionTo 'stories.show', s.get('id')

    toggleShowInIframe: -> @controller.set 'showInIframe', !@controller.get('showInIframe')
    toggleSandboxIframe: -> @controller.set 'sandboxIframe', !@controller.get('sandboxIframe')

    backToFeed: ->
      id = @controller.get('model.feed.id')
      @transitionTo('feeds.stories', id)

`export default R`
