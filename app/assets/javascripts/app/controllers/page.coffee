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
      
  app.vent.on 'PAGE:show', (id)->
    controllers.Page.show(id)
    app.router.navigate "pages/#{id}"
