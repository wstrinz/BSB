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
  unreadButtonsInIndex: false
  showRead: false

`export default C`
