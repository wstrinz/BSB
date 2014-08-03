import Ember from 'ember';

export default Ember.ArrayController.extend({
  sortProperties: ['timestamp', 'id'],
  sortAscending: false,

  actions: {
    toggleShowRead: function(){
      var su = this.get('showRead');
      if(su === undefined || su === true){
        this.set('showRead', false);
      }
      else{
        this.set('showRead', true);
      }
    },
    toggleRead: function(id){
      this.store.find('story', id).then(
      function(s){
        if(s.get('read')){ s.set('read', false); }
        else{ s.set('read', true); }

        s.save();
      });
    }
  },
  showReadStories: function(){
    var su = this.get('showRead');
    if(su === undefined){
      this.set('showRead', false);
      return false;
    }
    else{
      return su;
    }
  }.property('showRead'),
  unreadStories: function(){
    return this.filter(function(story){
      return story.get('read') === false;
    });
  }.property('@each.read')
});
