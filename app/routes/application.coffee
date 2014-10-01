`import Ember from 'ember'`

R = Ember.Route.extend
  shortcuts:
    'j': 'nextItem'
    'x': 'nextItem'
    'k': 'prevItem'
    'z': 'prevItem'
    'c': 'viewItem'
    'o': 'viewAndMarkItem'
    'shift+o': 'viewItem'
    'm': 'toggleCurrentRead'
    'u': 'toggleCurrentRead'
    'f': 'backToFeed'
    'r': 'resetFocus'
    'p': 'toggleShowInIframe'
    's': 'toggleSandboxIframe'
    'shift+f': 'backToHome'
    'shift+s': 'backToStories'

  actions:
    backToHome: -> @transitionTo('feeds.index')
    backToStories: -> @transitionTo('stories.index')


`export default R`
