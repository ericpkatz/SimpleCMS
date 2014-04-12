describe 'App.Page.Views.Show', ()->

  describe 'Page With Contents', ()->
    beforeEach ()->
      @json = {"id":10,"title":"Human Division Designer","body":"Exercitationem officiis odio nisi. Deleniti aperiam quo. Tempore dicta sint voluptas amet minus similique.","priority":5,"created_at":"2014-04-12T10:57:21.819Z","updated_at":"2014-04-12T10:57:21.819Z","is_home_page":false,"contents":[{"id":1,"title":"Global Interactions Consultant","body":"Quae necessitatibus non aliquid omnis explicabo magni. Qui pariatur aut quibusdam. Totam reiciendis quod.","page_id":10,"priority":5,"created_at":"2014-04-12T10:57:21.868Z","updated_at":"2014-04-12T10:57:21.868Z"},{"id":2,"title":"Global Interactions Consultant","body":"Quae necessitatibus non aliquid omnis explicabo magni. Qui pariatur aut quibusdam. Totam reiciendis quod.","page_id":10,"priority":5,"created_at":"2014-04-12T10:57:21.873Z","updated_at":"2014-04-12T10:57:21.873Z"},{"id":3,"title":"Global Interactions Consultant","body":"Quae necessitatibus non aliquid omnis explicabo magni. Qui pariatur aut quibusdam. Totam reiciendis quod.","page_id":10,"priority":5,"created_at":"2014-04-12T10:57:21.877Z","updated_at":"2014-04-12T10:57:21.877Z"}]}

      @model = new App.Models.Page @json
      @view = new App.Page.Views.Show
        model: @model
        
      setFixtures @view.render().$el

    it 'Shows the title of the page', ()->
      expect($('.jumbotron').html()).toContain(@model.get('title'))
    it 'Shows the body of the page', ()->
      expect($('.jumbotron').html()).toContain(@model.get('body'))

    # it 'Shows the content items', ()->
      # html = @view.$el.html()
      # _.forEach @model.get('contents'), (item)->
        # expect(html).toContain item.title
