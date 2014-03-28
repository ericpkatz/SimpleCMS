describe 'App.Header.Views.Brand', ->
  beforeEach ()->
      @model = new App.Models.Page
        id: 11
        title: 'Home'
      @view = new App.Header.Views.Brand
        model: @model

      setFixtures @view.render().$el

  describe 'Rendering', ->
    it 'Shows the brand', ->
      expect(@view.$el.html()).toContain(@model.get('title'))

  describe 'Clicking on the brand', ->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @view.$('a.navbar-brand').click()

    it 'Fires the PAGE:show event with the model\'s id', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'PAGE:show', @model.get('id')
      
