`import Ember from 'ember'`

V = Ember.View.extend
  hammerOptions:
    swipe_velocity: 0.75

  gestures:
    swipeLeft: (e) ->
      e.gesture.stopDetect()
      e.gesture.preventDefault()
      this.controller.send('nextStory')
    swipeRight: (e) ->
      debugger
      e.gesture.stopDetect()
      e.gesture.preventDefault()
      this.controller.send('prevStory')
    rotate: (e) ->
      e.gesture.stopDetect()
      e.gesture.preventDefault()
      this.controller.send('toggleRead')

`export default V`
