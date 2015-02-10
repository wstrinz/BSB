`import Ember from 'ember'`

C = Ember.ObjectController.extend
  needs: ['application']
  showInIframe: Ember.computed.alias('controllers.application.showInIframe')
  sandboxIframe: false
  contentForStory: Ember.computed 'story_content', ->
    content = @get('story_content')
    summary = @get('summary')

    if content
      content
    else if summary
      summary
    else
      ""

  actions:
    toggleRead: ->
      model = @get 'model'
      model.set 'read', !model.get('read')
      model.save()

`export default C`
