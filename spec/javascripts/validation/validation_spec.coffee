describe 'App.Validation', ()->
  beforeEach ()->
    @controller = new App.Validation.Controller()

  describe 'Firing the validation event',()->
    beforeEach ()->
      spyOn @controller, 'sendErrors'
      App.vent.trigger 'VALIDATION:error', 'bizz', 'buzz'

    it 'sendErrors', ()->
      expect(@controller.sendErrors).toHaveBeenCalledWith 'bizz', 'buzz'
