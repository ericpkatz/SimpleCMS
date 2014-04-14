describe 'App.Content.Views.Form', ()->
  beforeEach ()->
    @view = new App.Content.Views.Form
      model: new App.Models.Content
        title: 'foo' 
        body: 'bar'
        priority: 3 
        
    @view.render()
    # setFixtures @view.render().$el
  it 'exists', ()->
    expect(@view).toBeTruthy()

  it 'has a title of foo', ()->
    expect(@view.ui.title.val()).toEqual 'foo'

  it 'has a body of bar', ()->
    expect(@view.ui.body.val()).toEqual 'bar'

  it 'has a priority of 3', ()->
    expect(@view.ui.priority.val()).toEqual '3' 

  describe 'clicking submit', ()->
    beforeEach ()->
      spyOn(@view, 'save').andCallThrough()
      spyOn(App.vent, 'trigger').andCallThrough()
      @view.ui.submit.click()

    it 'calls save', ()->
      expect(@view.save).toHaveBeenCalled()

    it 'fires CONTENT:save event', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith('CONTENT:save', @view.model)
