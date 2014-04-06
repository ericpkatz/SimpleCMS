describe "App.Page.Views.FormLayout", ()->
  beforeEach ()->
    @model = new App.Models.Page
      title: 'monkey'
    @layout = new App.Page.Views.FormLayout
      page: @model
    setFixtures @layout.render().el
  
  it "Displays the form for editing a page", ()->
    expect(@layout.form.currentView.ui.title.val()).toEqual(@model.get('title'))

  describe "When VALIDATION:PAGE:errors fires", ()->
    beforeEach ()->
      @view = new Backbone.View()
      App.vent.trigger 'PAGE:errors', @view

    it "ValidationErrors region displays the view", ()->
      expect(@layout.validationErrors.currentView).toBe(@view)
      
