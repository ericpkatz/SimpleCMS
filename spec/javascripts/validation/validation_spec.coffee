describe 'App.Validation', ()->

  describe 'Firing the validation event',()->
    beforeEach ()->
      App.vent.trigger 'VALIDATION:error', ['hello', 'world']

    it 'Validation errors are shown', ()->
      console.log 'figure out how to put validation within another region'
      # expect(1).toEqual(2)
