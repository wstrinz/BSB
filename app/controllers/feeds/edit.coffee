`import Ember from 'ember'`

FeedsEditController = Ember.Controller.extend
  actions:
    updateFeed: ->
      @get('model').save()
      @transitionToRoute('stories', @get('model.id'))

    deleteFeed: ->
      @get('model').destroyRecord()
      @transitionToRoute('feeds')

`export default FeedsEditController`
