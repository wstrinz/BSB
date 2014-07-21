// For more information see: http://emberjs.com/guides/routing/

import Ember from 'ember';

var Router = Ember.Router.extend({
  location: CliTestENV.locationType
});

Router.map(function() {
  this.resource('feeds', { path: '/feeds' });
  this.resource('feed', { path: 'feeds/:feed_id' });
});

export default Router;
//App.Router.map(function() {
  //this.resource('feeds', { path: '/feeds' });
  //this.resource('feed', { path: 'feeds/:feed_id' });
//});

//App.FeedsRoute = Ember.Route.extend({
  //model: function(){
    //return this.store.find('feed');
  //}
//});

//App.IndexRoute = Ember.Route.extend({
  //redirect: function() {
   //this.transitionTo('feeds');
  //}
//});
