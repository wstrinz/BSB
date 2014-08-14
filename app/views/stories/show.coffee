`import Ember from 'ember'`

V = Ember.View.extend
  hammerOptions:
    swipe_velocity: 0.5

  gestures:
    swipeLeft: ->
      this.controller.send('nextStory')
    swipeRight: ->
      this.controller.send('prevStory')

`export default V`
