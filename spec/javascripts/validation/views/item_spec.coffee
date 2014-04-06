describe 'App.Validation.Views.Item', ()->
  beforeEach ()->
    @model= new Backbone.Model
        message: 'bad data'
    @view = new App.Validation.Views.Item
      model: @model 
    setFixtures @view.render().el

  it "Shows the validation error", ()->
    expect(@view.$el.html()).toContain(@model.get('message'))
