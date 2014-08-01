import Ember from 'ember';

export default Ember.ArrayController.extend({
  add_feed: function(){
    var url = Ember.$('#add_feed').val();
    var new_feed = this.store.createRecord('feed', {feed_url: url, name: 'temp'});
    new_feed.save();
  }
});
