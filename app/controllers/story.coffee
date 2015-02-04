`import Ember from 'ember'`

C = Ember.ObjectController.extend
  needs: ['application']
  showInIframe: Ember.computed.alias('controllers.application.showInIframe')
  sandboxIframe: false
  storyKeywords: Ember.computed ->
    @get('model.keywords').then ->
      console.log(arguments)

    ["kwds"]


  actions:
    toggleRead: ->
      model = @get 'model'
      model.set 'read', !model.get('read')
      model.save()

`export default C`
