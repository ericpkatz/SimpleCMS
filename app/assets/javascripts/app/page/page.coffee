App.module 'Controllers', (controllers, app) ->

  controllers.Page =
    show: (id)->
      app.getPage id, (data, admin = false)->
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
          app.main.show new app.Page.Views.Edit
            model: new app.Models.Page data
        true
      )

    insert: (id)->
      app.main.show new app.Page.Views.Insert
        model: new app.Models.Page
          parent_id: id

    delete: (id)->
      app.deletePage id, (data) ->
        App.vent.trigger 'PAGE:change'
        App.vent.trigger 'PAGE:show', data.id
        App.vent.trigger 'FLASH:show', 'Page has been deleted'

      
  app.vent.on 'PAGE:show', (id)->
    controllers.Page.show(id)

  app.vent.on 'PAGE:edit', (id)->
    controllers.Page.edit(id) 
    app.vent.trigger 'ROUTER:navigate', "pages/#{id}/edit"

  app.vent.on 'PAGE:insert', (id)->
    controllers.Page.insert(id) 
    app.vent.trigger 'ROUTER:navigate',"pages/#{id}/new"

  app.vent.on 'PAGE:delete', (id)->
    controllers.Page.delete(id) 

  app.vent.on 'PAGE:save', (model)->
    app.savePage model, (data) ->
      App.vent.trigger 'CACHE:set', 'Page', data.id, data
      App.vent.trigger 'PAGE:change'
      App.vent.trigger 'PAGE:show', data.id
      App.vent.trigger 'FLASH:show', 'Page has been saved'


