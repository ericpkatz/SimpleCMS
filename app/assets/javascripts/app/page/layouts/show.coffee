App.module 'Page.Layouts', (Layouts, App)->
  Layouts.Show = Marionette.Layout.extend
    initialize: (options)->
      @model = options.page
      @admin = options.admin
    regions:
      page: '#page'
      contents: '#contents'
    template: JST["page/show_layout"]
    showPage: ()->
      @page.show new App.Page.Views.Show
        model: @model
        admin: @admin
    showContents:()->
      @contents.show new App.Content.Views.List
        collection: @model.contents()
    onRender: ()->
      @showPage()
      @showContents()
