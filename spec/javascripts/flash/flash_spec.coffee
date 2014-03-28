describe 'FlashController', ->
  describe 'FLASH:show event is fired', ->
    beforeEach ()->
      @notice = 'Hello'
      spyOn App.Flash.Controller, 'show'
      App.vent.trigger 'FLASH:show', @notice 

    it 'Renders the show view', ->
      expect(App.Flash.Controller.show).toHaveBeenCalledWith @notice
