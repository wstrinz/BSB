import { test, moduleForModel } from 'ember-qunit';

moduleForModel('feed', 'Feed', {
  // Specify the other units that are required for this test.
  needs: ['model:story']
});

test('it exists', function() {
  var model = this.subject();
  // var store = this.store();
  ok(model);
});
