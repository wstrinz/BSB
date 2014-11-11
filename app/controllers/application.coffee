`import Ember from 'ember'`

C = Ember.Controller.extend
  storySort: 'score'
  sortMethod: Ember.computed 'storySort', ->
    [@get 'storySort', 'id']
  nextSort: Ember.computed 'storySort', ->
    if @get('storySort') == 'timestamp'
      'score'
    else
      'timestamp'
  isMobile: Ember.computed ->
    typeof(window.orientation) != 'undefined'

  unreadButtonsInIndex: Ember.computed 'isMobile', ->
    @get 'isMobile'

  showRead: false
  showInIframe: false


`export default C`
