describe 'Flash.Views.Show', ->
  describe 'When it has a notice', ->
    beforeEach ()->
      @view = new App.Flash.Views.Show
        model: new Backbone.Model
          notice: 'Hello World' 
      setFixtures @view.render().$el
    describe 'Rendering', ->
      it 'renders the notice', ->
        expect(@view.$el.html()).toContain 'Hello World'

    describe 'Dismissing', ->
      it 'dismisses the notice', ->
        $('.close').click()
        expect(@view.$el.html()).not.toContain 'Hello World'
