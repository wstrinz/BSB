`import Ember from 'ember'`
`import pagedArray from 'ember-cli-pagination/computed/paged-array'`

M = Ember.Mixin.create
  queryParams: ["page", "perPage"],

  pageBinding: "content.page"
  perPageBinding: "content.perPage"
  totalPagesBinding: "content.totalPages"

  page: 1
  perPage: 10

  storiesLeft: Ember.computed 'focusedStory', ->
    current = @get 'focusedStory'
    model_content = @get 'model.arrangedContent'
    showRead = @get 'showReadStories'

    unless showRead
      model_content = model_content.filter (c) -> c.get('read') == false

    model_content.length - model_content.indexOf(current)

  shouldPaginate: Ember.observer 'storiesLeft', ->
    return false
    if @get('storiesLeft') <= @get('paginateAt')
      @send 'loadNextPage'

  actions:
    loadNextPage: -> return null #@get('pagedContent').loadNextPage()

`export default M`
