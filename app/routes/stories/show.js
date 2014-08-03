import Ember from 'ember';

export default Ember.Route.extend({
  model: function(params){
    return this.store.find('story', params.story_id);
  },

  afterModel: function(story){
    story.set('read', true);
    story.save();
  },

  actions: {
    markUnread: function(){
      var mod = this.controller.get('model');
      mod.set('read', false);
      mod.save();
      this.transitionTo('feeds.stories', mod.get('feed').get('id'));
    }
  }
});
