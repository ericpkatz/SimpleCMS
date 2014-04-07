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
    @view = new App.Content.Views.List
      collection : @collection
    @view.render()
  it 'Shows the collection of items', ()->
    v = @view
    @collection.each (item)->
      expect(v.$el.html()).toContain item.get('title')
