`import Ember from 'ember'`

RouteNextPrevMixin = Ember.Mixin.create
  actions:
    nextItem: -> @controller.send('nextItem')
    prevItem: -> @controller.send('prevItem')

`export default RouteNextPrevMixin`
