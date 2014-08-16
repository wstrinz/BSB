`import Ember from 'ember'`

C = Ember.Controller.extend
  storySort: 'timestamp'
  sortMethod: Ember.computed 'storySort', ->
    [@get 'storySort']
  nextSort: Ember.computed 'storySort', ->
    if @get('storySort') == 'timestamp'
      'sharecount'
    else
      'timestamp'

`export default C`
