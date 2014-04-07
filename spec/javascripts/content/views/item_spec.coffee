describe 'App.Content.Views.Item', ()->
  beforeEach ()->
    @model = new App.Models.Content
      title: 'hello'
    @view = new App.Content.Views.Item
      model: @model
      
    @view.render()

  it 'Shows the title of the content item', ()->
    expect(@view.$el.html()).toContain 'hello'
