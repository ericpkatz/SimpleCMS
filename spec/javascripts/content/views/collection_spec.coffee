describe 'App.Content.Views.Collection', ()->
  beforeEach ()->
    @collection = new App.Collections.Contents [
      {
        title: 'hello'
      },
      {
        title: 'world'
      }
    ]
    @admin = false
    @data = 
      collection : @collection
      admin: @admin
    @view = new App.Content.Views.List @data
    spyOn(@view, 'initialize').andCallThrough()
    @view.render()

  it 'Shows the collection of items', ()->
    v = @view
    @collection.each (item)->
      expect(v.$el.html()).toContain item.get('title')
