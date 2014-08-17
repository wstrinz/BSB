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
    'shift+s': 'backToStories'

  actions:
    backToHome: -> @transitionTo('feeds.index')
    backToStories: -> @transitionTo('stories.index')

`export default R`
