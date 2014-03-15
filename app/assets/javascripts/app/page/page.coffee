App.module 'Controllers', (controllers, app) ->

  controllers.Page =
    show: (id)->
      app.getPage id, (data)->
        page = new app.Models.Page data
        app.main.show new app.Page.Views.Show
          model: page 

        if page.get('is_home_page')
          app.router.navigate '/'
        else
          app.router.navigate "pages/#{page.get('id')}"

    edit: (id)->
      app.getPage( 
        id 
        (data)->
          app.main.show new app.Page.Views.Edit
            model: new app.Models.Page data
        true
      )

    insert: (id)->
      app.main.show new app.Page.Views.Insert
        model: new app.Models.Page
          parent_id: id

    delete: (id)->
      app.deletePage(id)

      
  app.vent.on 'PAGE:show', (id)->
    controllers.Page.show(id)
    app.router.navigate "pages/#{id}"

  app.vent.on 'PAGE:edit', (id)->
    controllers.Page.edit(id) 
    app.router.navigate "pages/#{id}/edit"

  app.vent.on 'PAGE:insert', (id)->
    controllers.Page.insert(id) 
    app.router.navigate "pages/#{id}/new"

  app.vent.on 'PAGE:delete', (id)->
    controllers.Page.delete(id) 

  app.vent.on 'PAGE:save', (model)->
    app.savePage(model)

