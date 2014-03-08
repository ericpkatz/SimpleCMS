@App.module 'Controllers', (controllers, app, marionette, backbone, jquery, _) ->
  API = 
    getPages: -> 
      app.getPages API.showList 
    showList: (pages)->
      app.header.show new App.Views.Header
        collection: new Backbone.Collection pages


  controllers.Header = 
    list: -> API.getPages()

  app.vent.on 'HEADER:list', ->
    controllers.Header.list()

