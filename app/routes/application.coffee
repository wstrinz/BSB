`import Ember from 'ember'`

R = Ember.Route.extend
  defaultShortcuts:
    'j': 'nextItem'
    'k': 'prevItem'
    'o': 'viewAndMarkItem'
    'shift+o': 'viewItem'
    'shift+a': 'showAllFeeds'
    'm': 'toggleCurrentRead'
    'r': 'resetFocus'
    'p': 'addCurrentToPocket'
    'shift+/': 'showHelp'

    #'p': 'toggleShowInIframe'

  shortcuts: {}

  shortcutsLoaded: false

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.getLoginStatus()
    controller.checkIfLinkedToPocket()

  actions:
    backToHome: -> @transitionTo('feeds.index')
    backToStories: -> @transitionTo('stories.index')
    reloadShortcuts: ->
      _this = this
      @store.find('shortcut').then (shortcuts) ->
        server_shortcuts = {}
        shortcuts.map (s) -> server_shortcuts[s.get('key')] = s.get('action')
        new_shortcuts = Ember.$.extend(_this.defaultShortcuts, server_shortcuts)
        _this.shortcuts = new_shortcuts
        _this.controller.shortcuts.destroy()
        _this.registerShortcuts()
        _this.controller.shortcuts.init()

      false

    didTransition: ->
      unless @get('shortcutsLoaded')
        @set('shortcutsLoaded', true)
        @send('reloadShortcuts')

    showHelp: ->
      @transitionTo('help')
    showAllFeeds: ->
      @transitionTo('feeds.all', queryParams: {page: '0'})

`export default R`
