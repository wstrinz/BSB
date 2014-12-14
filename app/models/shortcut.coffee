`import DS from 'ember-data'`

Shortcut = DS.Model.extend
  key: DS.attr 'string'
  action: DS.attr 'string'

`export default Shortcut`
