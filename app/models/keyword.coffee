`import DS from 'ember-data'`

Keyword = DS.Model.extend {
  name: DS.attr 'string'
  story: DS.belongsTo 'story'
}

`export default Keyword`
