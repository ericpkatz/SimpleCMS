describe 'App.Page.Layouts.Show', ()->
  beforeEach ()->
    @json = {"id":10,"title":"Human Division Designer","body":"Exercitationem officiis odio nisi. Deleniti aperiam quo. Tempore dicta sint voluptas amet minus similique.","priority":5,"created_at":"2014-04-12T10:57:21.819Z","updated_at":"2014-04-12T10:57:21.819Z","is_home_page":false,"contents":[{"id":1,"title":"Global Interactions Consultant","body":"Quae necessitatibus non aliquid omnis explicabo magni. Qui pariatur aut quibusdam. Totam reiciendis quod.","page_id":10,"priority":5,"created_at":"2014-04-12T10:57:21.868Z","updated_at":"2014-04-12T10:57:21.868Z"},{"id":2,"title":"Global Interactions Consultant","body":"Quae necessitatibus non aliquid omnis explicabo magni. Qui pariatur aut quibusdam. Totam reiciendis quod.","page_id":10,"priority":5,"created_at":"2014-04-12T10:57:21.873Z","updated_at":"2014-04-12T10:57:21.873Z"},{"id":3,"title":"Global Interactions Consultant","body":"Quae necessitatibus non aliquid omnis explicabo magni. Qui pariatur aut quibusdam. Totam reiciendis quod.","page_id":10,"priority":5,"created_at":"2014-04-12T10:57:21.877Z","updated_at":"2014-04-12T10:57:21.877Z"}]}

    @model = new App.Models.Page @json
    @layout = new App.Page.Layouts.Show
      page: @model
    spyOn(@layout, 'showPage').andCallThrough()
    spyOn(@layout, 'showContents').andCallThrough()
    setFixtures @layout.render().$el
    @html = @layout.$el.html()

  it 'fires the showPage event', ()->
    expect(@layout.showPage).toHaveBeenCalled()

  it 'shows the title of the page', ()->
    expect(@html).toContain(@json.title)

  it 'fires the showContents event', ()->
    expect(@layout.showContents).toHaveBeenCalled()

  it 'shows the content items', ()->
    html = @html
    @model.contents().each (item)->
      expect(html).toContain item.get('title')
