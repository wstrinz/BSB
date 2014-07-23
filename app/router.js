// For more information see: http://emberjs.com/guides/routing/

import Ember from 'ember';

var Router = Ember.Router.extend({
  location: FeedEmberENV.locationType
});

Router.map(function() {
  this.resource('feeds', function(){
    this.route('show', { path: '/:feed_id' });
  });
  this.resource('stories', function(){
    this.route('show', { path: '/:story_id' });
  });
});

export default Router;
