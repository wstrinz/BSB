`import Ember from 'ember'`

V = Ember.View.extend
  hammerOptions:
    swipe_velocity: 0.5

  gestures:
    swipeLeft: (event) ->
      this.controller.send('nextStory')
    swipeRight: (event) ->
      this.controller.send('prevStory')

`export default V`
