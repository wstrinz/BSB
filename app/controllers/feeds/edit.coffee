`import Ember from 'ember'`

FeedsEditController = Ember.Controller.extend
  actions:
    updateFeed: ->
      @get('model').save()
      @transitionToRoute('stories', @get('model.id'))

`export default FeedsEditController`
