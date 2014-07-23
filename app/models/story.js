import DS from 'ember-data';

export default DS.Model.extend({
  title: DS.attr('string'),
  author: DS.attr('string'),
  url: DS.attr('string'),
  summary: DS.attr('string'),
  content: DS.attr('string'),
  feed: DS.belongsTo('feed')
});
