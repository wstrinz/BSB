import Ember from 'ember';

export default Ember.Route.extend({
  model: function(params){
    return this.store.find('feed', params.feed_id).then(
      function(f){ return f.get('stories'); }
    );
  }
});
