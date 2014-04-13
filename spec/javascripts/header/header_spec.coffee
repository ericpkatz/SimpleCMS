describe 'Header.Controller', ->
  beforeEach ()->
    @controller = new App.Header.Controller()

  afterEach ()->
    App.vent._events = []

  describe 'HEADER:list is called', ()->
    beforeEach ()->
      spyOn @controller, 'list'
      App.vent.trigger 'HEADER:list', 'foo', 'bar'

    it 'calls the list method', ->
      expect(@controller.list).toHaveBeenCalledWith 'foo', 'bar'

  describe 'PAGE:show is called', ()->
    beforeEach ()->
      spyOn @controller, 'highlightPage'
      App.vent.trigger 'PAGE:show', { id: 'foo' } 

    it 'calls the highlightPage method', ->
      expect(@controller.highlightPage).toHaveBeenCalledWith 'foo'

  describe 'NAV:show is called', ()->
    beforeEach ()->
      spyOn @controller, 'highlightPage'
      App.vent.trigger 'NAV:show', 'bar' 

    it 'calls the highlightPage method', ->
      expect(@controller.highlightPage).toHaveBeenCalledWith 'bar'

  describe 'HEADER:shown is called', ()->
    beforeEach ()->
      spyOn(@controller, 'deferred').andReturn $.Deferred()
      App.vent.trigger 'HEADER:shown' 

    it 'calls the deferred', ->
      expect(@controller.deferred).toHaveBeenCalled()

  describe 'PAGE:change is called', ()->
    beforeEach ()->
      App.vent.trigger 'PAGE:change', {} 

    it 'resets deferred', ->
      expect(@controller._deferred).toBeNull()
