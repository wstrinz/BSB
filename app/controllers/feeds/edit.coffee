`import Ember from 'ember'`

FeedsEditController = Ember.Controller.extend
  actions:
    updateFeed: ->
      new_time_decay = Ember.$('#time_decay').val() == "on"
      @set('model.time_decay', new_time_decay)
      @get('model').save()

`export default FeedsEditController`
