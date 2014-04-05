App.module 'Controllers', (controllers, app) ->

  controllers.Page =
    show: (data, admin)->
      page = new app.Models.Page data
      page.set('admin', admin)
      app.main.show new app.Page.Views.Show
        model: page

      if page.get('is_home_page')
        app.vent.trigger 'ROUTER:navigate', '/'
      else
        app.vent.trigger 'ROUTER:navigate', "pages/#{page.get('id')}"

    edit: (id)->
      app.getPage( 
        id 
        (data)->
          app.main.show new app.Page.Views.Form
            model: new app.Models.Page data
        true
      )

    insert: (id)->
      app.main.show new app.Page.Views.Form
        model: new app.Models.Page
          parent_id: id

      
  app.vent.on 'PAGE:show', (data, admin)->
    controllers.Page.show(data, admin)

  app.vent.on 'PAGE:edit', (id)->
    controllers.Page.edit(id) 
    app.vent.trigger 'ROUTER:navigate', "pages/#{id}/edit"

  app.vent.on 'PAGE:insert', (id)->
    controllers.Page.insert(id) 
    app.vent.trigger 'ROUTER:navigate',"pages/#{id}/new"


