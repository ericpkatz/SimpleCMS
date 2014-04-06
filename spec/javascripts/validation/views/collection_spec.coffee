describe 'App.Validation.Views.Collection', ()->
  beforeEach ()->
    @collection = new Backbone.Collection [
      new Backbone.Model
        message: 'hello'
      new Backbone.Model
        message: 'world'
    ]
    @view = new App.Validation.Views.Collection
      collection : @collection
    setFixtures @view.render().el

  it "shows the items", ()->
    expect(@view.$el.html()).toContain @collection.models[0].get('message')
    expect(@view.$el.html()).toContain @collection.models[1].get('message')
