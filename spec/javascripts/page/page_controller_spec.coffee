describe 'App.Page.Controller', ()->
  beforeEach ()->
    @controller = new App.Page.Controller()
  afterEach ()->
    App.vent._events = []

  describe 'constructing', ()->
    it 'can be constructed', ()->
      expect(@controller).toBeTruthy()

  describe 'When PAGE:show event fires', ()->
    beforeEach ()->
      spyOn @controller, 'show'
      App.vent.trigger 'PAGE:show', 'foo', 'bar'

    it "show is called with foo and bar", ()->
      expect(@controller.show).toHaveBeenCalledWith 'foo', 'bar'

  describe 'When PAGE:edit event fires', ()->
    beforeEach ()->
      spyOn @controller, 'edit'
      App.vent.trigger 'PAGE:edit', 'bizz'

    it "edit event is called with bizz", ()->
      expect(@controller.edit).toHaveBeenCalledWith 'bizz'

  describe 'When PAGE:insert event fires', ()->
    beforeEach ()->
      spyOn @controller, 'insert'
      App.vent.trigger 'PAGE:insert', 'bazz'

    it "edit event is called with bazz", ()->
      expect(@controller.insert).toHaveBeenCalledWith 'bazz'
