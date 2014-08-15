import { test, moduleForModel } from 'ember-qunit';

moduleForModel('story', 'Story', {
  // Specify the other units that are required for this test.
  needs: ['model:feed']
});

test('it exists', function() {
  var model = this.subject();
  // var store = this.store();
  ok(model);
});
