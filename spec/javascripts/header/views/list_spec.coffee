describe 'App.Header.Views.List', ->
  describe 'With two pages', ->
    beforeEach ->
      @collection = new App.Collections.Pages [
        { id: 1, title: 'Foo' }
        { id: 2, title: 'Bar' }
      ]
      @view = new App.Header.Views.List
        collection: @collection
      setFixtures @view.render().$el

    it "Shows two pages", ->
      expect(@view.children.length).toEqual 2

    describe 'Clicking on the first page link', ->
      beforeEach ->
        spyOn window.App.vent, 'trigger'
        @view.children.first().$('a').click()

      it "Expect PAGE:show event to be fired with the id of the page link's model id", ->
        expect(window.App.vent.trigger).toHaveBeenCalledWith('PAGE:show', @collection.first().get('id'))
