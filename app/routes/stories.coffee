`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`
`import RouteNextPrevMixin from 'feed-ember/mixins/route-next-prev'`
`import Notify from 'ember-notify'`

R = Ember.Route.extend RouteMixin, RouteNextPrevMixin,
  model: (params) ->
    appcon = @controllerFor('application')
    @set('feed_id', params.feed_id)
    filter_params = sort: appcon.get('storySort'), feed_id: params.feed_id
    unless appcon.get('showRead')
      filter_params["read"] = false

    @findPaged 'story', filter_params

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.send 'resetFocus', false

  actions:
    viewItem: -> @controller.send('viewItem')
    toggleCurrentRead: -> @controller.send('toggleCurrentRead')
    viewAndMarkItem: ->
      @controller.send('viewInBackground')
      @controller.send('toggleCurrentRead')
    toggleShowInIframe: ->
      c = @controllerFor('application')
      c.set 'showInIframe', !c.get('showInIframe')
    toggleSandboxIframe: -> @set 'sandboxIframe', !@get('sandboxIframe')

    addCurrentToPocket: ->
      current_id = @controller.get('currentStory').get('id')
      @controller.send('toggleCurrentRead')
      Ember.$.post("/api/stories/#{current_id}/to_pocket").then((resp) ->
        Notify.success('added to pocket!', closeAfter: 3000)
      ).fail( (resp) ->
        Notify.alert('failed to add story!', closeAfter: 3000)
      )
      false

    reload: ->
      appcon = @controllerFor('application')
      model = @controller.get('model')

      @store.find('story',
        feed_id: @get('feed_id'),
        read: appcon.get('showRead'),
        sort: appcon.get('storySort'),
        page: @controller.get('page')
      ).then (stories) ->
        ids = model.mapProperty('id')
        stories = stories.reject (s) -> ids.contains(s.get 'id')
        model.addObjects(stories)

`export default R`
