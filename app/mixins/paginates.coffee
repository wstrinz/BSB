`import Ember from 'ember'`

M = Ember.Mixin.create
  paginateAt: 6
  page: 1

  storiesLeft: Ember.computed 'focusedStory', ->
    current = @get 'focusedStory'
    model_content = @get 'model.arrangedContent'
    showRead = @get 'showReadStories'

    unless showRead
      model_content = model_content.filter (c) -> c.get('read') == false

    model_content.length - model_content.indexOf(current)

  shouldPaginate: Ember.observer 'storiesLeft', ->
    if @get('storiesLeft') <= @get('paginateAt')
      @send 'loadNextPage'

  actions:
    loadNextPage: ->
      @set('page', @get('page') + 1)
      @send('reload')

`export default M`
