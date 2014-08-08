`import Ember from 'ember'`

C = Ember.ObjectController.extend
  needs: ['feeds/stories']
  showInIframe: true
  actions:
    nextStory: ->
      console.log @get('controllers.feeds/stories.nextFeedStory')

    toggleShowInIframe: ->
      if @get('showInIframe')
        @set('showInIframe', false)
      else
        @set('showInIframe', true)

`export default C`
