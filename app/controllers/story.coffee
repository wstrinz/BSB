`import Ember from 'ember'`

C = Ember.ObjectController.extend
  needs: ['application']
  showInIframe: Ember.computed.alias('controllers.application.showInIframe')
  sandboxIframe: false

  actions:
    toggleRead: ->
      model = @get 'model'
      if model.get 'marking'
        Ember.run.cancel model.get('marking')
      else
        model.set 'marking', Ember.run.later(this, ->
          model.set 'read', !model.get('read')
          model.save()
          model.set 'marking', null
        , 3500)

`export default C`
