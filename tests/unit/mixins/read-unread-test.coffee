`import Ember from 'ember'`
`import ReadUnreadMixin from 'feed-ember/mixins/read-unread'`

module 'ReadUnreadMixin'

# Replace this with your real tests.
test 'it works', ->
  ReadUnreadObject = Ember.Object.extend ReadUnreadMixin
  subject = ReadUnreadObject.create()
  ok subject
