`import Ember from 'ember'`

C = Ember.ObjectController.extend
  needs: ['application']
  showInIframe: Ember.computed.alias('controllers.application.showInIframe')
  sandboxIframe: false

`export default C`
