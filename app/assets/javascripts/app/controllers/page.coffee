App.module 'Controllers', (controllers, app) ->
  API =
    getPage: (id)->
      app.getPage(id, API.showPage)
    showPage: (data)->
      app.main.show new app.Views.Page
        model: new app.Models.Page data 

  controllers.Page =
    show: (id)->
      API.getPage id
    editPage: (id)->
      app.getPage id, (data)->
        app.main.show new app.Views.PageEdit
          model: new app.Models.Page data
      
  app.vent.on 'PAGE:show', (id)->
    controllers.Page.show(id)
    app.router.navigate "pages/#{id}"

  app.vent.on 'PAGE:edit', (id)->
    controllers.Page.editPage(id) 
    app.router.navigate "pages/#{id}/edit"

  app.vent.on 'PAGE:save', (model)->
    app.savePage(model)
