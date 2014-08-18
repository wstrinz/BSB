`import Ember from 'ember'`

C = Ember.Controller.extend
  storySort: 'sharecount'
  sortMethod: Ember.computed 'storySort', ->
    [@get 'storySort']
  nextSort: Ember.computed 'storySort', ->
    if @get('storySort') == 'timestamp'
      'sharecount'
    else
      'timestamp'
  isMobile: Ember.computed ->
    typeof(window.orientation) != 'undefined'

  unreadButtonsInIndex: Ember.computed 'isMobile', ->
    @get 'isMobile'

  showRead: false

`export default C`
