describe 'App.Content.Views.Item', ()->
  describe 'User is not an admin', ()->
    beforeEach ()->
      @model = new App.Models.Content
        title: 'hello'
      @view = new App.Content.Views.Item
        model: @model
        
      @view.render()

    it 'Shows the title of the content item', ()->
      expect(@view.$el.html()).toContain 'hello'
    it 'Edit link is not shown', ()->
      expect(@view.ui.edit.length).toBe 0

  describe 'User is an admin', ()->
    beforeEach ()->
      @model = new App.Models.Content
        title: 'hello'
      @view = new App.Content.Views.Item
        model: @model
        admin: true
        
      @view.render()

    it 'Edit link is shown', ()->
      expect(@view.ui.edit.length).toBe 1

    describe 'Clicking on edit', ()->
      beforeEach ()->
        spyOn App.vent, 'trigger'
        @view.ui.edit.click()

      it 'fires CONTENT:edit event with model', ()->
        expect(App.vent.trigger).toHaveBeenCalledWith 'CONTENT:edit', @model

      # it 'fires the ROUTER:navigate event', ()->
        # expect(App.vent.trigger).toHaveBeenCalledWith 'ROUTER:navigate'
        

