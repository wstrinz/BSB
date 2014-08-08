`import Ember from 'ember'`

C = Ember.ObjectController.extend
  showInIframe: true
  actions:
    toggleShowInIframe: ->
      if @get('showInIframe')
        @set('showInIframe', false)
      else
        @set('showInIframe', true)

`export default C`
