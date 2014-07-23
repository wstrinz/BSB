// For more information see: http://emberjs.com/guides/routing/

import Ember from 'ember';

var Router = Ember.Router.extend({
  location: FeedEmberENV.locationType
});

Router.map(function() {
  this.resource('feeds', function(){
    this.route('show', { path: '/:feed_id' });
  });
  //this.resource('feed', { path: 'feeds/:feed_id' });
  this.resource('stories', { path: '/stories' });
});

export default Router;
