`import Ember from 'ember'`

R = Ember.Route.extend
  defaultShortcuts:
    'j': 'nextItem'
    'k': 'prevItem'
    'o': 'viewAndMarkItem'
    'shift+o': 'viewItem'
    'm': 'toggleCurrentRead'
    'u': 'toggleCurrentRead'
    'f': 'backToFeed'
    'r': 'resetFocus'
    'p': 'toggleShowInIframe'
    'R': 'reloadShortcuts'

  shortcuts:
    'j': 'nextItem'
    'k': 'prevItem'
    'o': 'viewAndMarkItem'
    'shift+o': 'viewItem'
    'm': 'toggleCurrentRead'
    'u': 'toggleCurrentRead'
    'f': 'backToFeed'
    'r': 'resetFocus'
    'p': 'toggleShowInIframe'
    'R': 'reloadShortcuts'

  shortcutsLoaded: false

  beforeModel: (transition) ->
    unless @get('shortcutsLoaded')
      @set('shortcutsLoaded', true)
      Ember.run.later(transition, ->
        this.send('reloadShortcuts')
      , 1500)


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


`export default R`
