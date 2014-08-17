`import Ember from 'ember'`

R = Ember.Route.extend
  shortcuts:
    'j': 'nextItem'
    'k': 'prevItem'
    'c': 'viewItem'
    'm': 'toggleCurrentRead'
    'u': 'toggleCurrentRead'
    'f': 'backToFeed'
    'shift+f': 'backToHome'

  actions:
    backToHome: -> @transitionTo('feeds.index')

`export default R`
