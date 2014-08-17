`import Ember from 'ember'`

V = Ember.View.extend
  hammerOptions:
    swipe_velocity: 0.75

  gestures:
    swipeLeft: (e) ->
      e.gesture.stopDetect()
      e.gesture.preventDefault()
      @controller.send('nextItem')

    swipeRight: (e) ->
      e.gesture.stopDetect()
      e.gesture.preventDefault()
      @controller.send('prevItem')

`export default V`
