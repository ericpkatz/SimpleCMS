describe 'FlashController', ->
  describe 'FLASH:show event is fired', ->
    beforeEach ()->
      @controller = new App.Flash.Controller()
      @notice = 'Hello'
      spyOn @controller, 'show'
      App.vent.trigger 'FLASH:show', @notice 

    it 'Renders the show view', ->
      expect(@controller.show).toHaveBeenCalledWith @notice
