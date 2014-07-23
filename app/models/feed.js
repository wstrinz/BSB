import DS from 'ember-data';

export default DS.Model.extend({
  feed_url: DS.attr('string'),
  name: DS.attr('string'),
  stories: DS.hasMany('story', {async: true})
});
