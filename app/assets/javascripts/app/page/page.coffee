App.module 'Page', (Page, app) ->

  class Page.Controller
    constructor: ()->
      app.vent.on 'PAGE:show', (data, admin)=>
        @show(data, admin)
      app.vent.on 'PAGE:edit', (id)=>
        @edit(id) 
      app.vent.on 'PAGE:insert', (id)=>
        @insert(id) 

    show: (data, admin)->
      page = new app.Models.Page data
      app.main.show new app.Page.Layouts.Show
        page: page
        admin: admin

      if page.get('is_home_page')
        app.vent.trigger 'ROUTER:navigate', '/'
      else
        app.vent.trigger 'ROUTER:navigate', "pages/#{page.get('id')}"

    edit: (id)->
      app.getPage( 
        id 
        (data)->
          app.main.show new app.Page.Views.FormLayout
            page: new app.Models.Page data
        true
      )
      app.vent.trigger 'ROUTER:navigate', "pages/#{id}/edit"

    insert: (id)->
      app.main.show new app.Page.Views.FormLayout
        page: new app.Models.Page
          parent_id: id
      app.vent.trigger 'ROUTER:navigate',"pages/#{id}/new"


  App.on 'start', ()->
    new App.Page.Controller()
