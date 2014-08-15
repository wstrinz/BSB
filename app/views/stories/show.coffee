`import Ember from 'ember'`

V = Ember.View.extend
  hammerOptions:
    swipe_velocity: 0.75

  gestures:
    swipeLeft: (e) ->
      e.gesture.stopDetect()
      e.gesture.preventDefault()
      @controller.send('nextStory')

    swipeRight: (e) ->
      e.gesture.stopDetect()
      e.gesture.preventDefault()
      console.log(e)
      @controller.send('prevStory')

    rotate: (e) ->
      e.gesture.stopDetect()
      e.gesture.preventDefault()
      if Math.abs(e.gesture.rotation) > 2
        @controller.send('toggleShowInIframe')
      else
        false

    doubletap: ->
      this.controller.send('toggleRead')

`export default V`
