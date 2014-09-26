`import Ember from 'ember'`

V = Ember.View.extend
  focusChanged: Ember.computed 'controller.focusedStory', ->
    @get('controller.focusedStory')

  #click: ->
    #@get('element').scrollIntoView(false)

`export default V`
