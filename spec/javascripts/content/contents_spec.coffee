describe 'App.Content.Controller', ()->
  beforeEach ()->
    @model = new App.Models.Content 
      id: 'foo'
    @controller = new App.Content.Controller()

  afterEach ()->
    App.vent._events = []

  describe 'Creation', ()->
    it 'Can be created', ()->
      expect(@controller).toBeTruthy()
      
  describe 'CONTENT:edit', ()->
    beforeEach ()->
      spyOn @controller, 'edit'
      spyOn @controller, 'navigate'
      App.vent.trigger 'CONTENT:edit', @model 
    it 'edit is called', ()->
      expect(@controller.edit).toHaveBeenCalledWith(@model)
    it 'navigate event is triggered with correct url', ()->
      expect(@controller.navigate).toHaveBeenCalledWith 'ROUTER:navigate', 'contents/foo/edit'

  describe 'CONTENT:delete', ()->
    beforeEach ()->
      spyOn(@controller, 'delete').andCallThrough()
      App.vent.trigger 'CONTENT:delete', @model 
    it 'delete is called', ()->
      expect(@controller.delete).toHaveBeenCalledWith(@model)

  describe 'CONTENT:save', ()->
    beforeEach ()->
      spyOn @controller, 'save'
      App.vent.trigger 'CONTENT:save', 'buzz'
    it 'save is called', ()->
      expect(@controller.save).toHaveBeenCalledWith('buzz')
