import Ember from 'ember';

export default Ember.Route.extend({
  model: function(){
    return this.store.find('story').then(function(s){return s;});
  }
});
