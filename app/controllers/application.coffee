`import Ember from 'ember'`

C = Ember.Controller.extend
  storySort: 'score'
  sortFunction: Ember.computed 'storySort', (x,y) ->
    method = @get('storySort')
    if x.get('id') == y.get('id')
      0
    else
      if x.get(method) == y.get(method)
        x.get('id') < y.get('id') ? -1 : 1
      else
        x.get(method) < y.get(method) ? -1 : 1

  nextSort: Ember.computed 'storySort', ->
    if @get('storySort') == 'timestamp'
      'score'
    else
      'timestamp'
  isMobile: Ember.computed ->
    typeof(window.orientation) != 'undefined'

  unreadButtonsInIndex: Ember.computed 'isMobile', ->
    @get 'isMobile'

  showRead: true
  showInIframe: false
  loggedIn: false
  linkedToPocket: false
  guest: true

  getLoginStatus: ->
    con = this
    Ember.$.ajax(url: '/loggedIn').then (resp) ->
      con.set('loggedIn', resp.logged_in == true)
      con.set('guest', resp.owner != true)

  checkIfLinkedToPocket: ->
    con = this
    Ember.$.ajax(url: '/linked_to_pocket').then (resp) ->
      con.set('linkedToPocket', resp.linked_to_pocket)

`export default C`
