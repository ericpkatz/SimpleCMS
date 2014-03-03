@App.module 'Controllers', (controllers, app, marionette, backbone, jquery, _) ->
  controllers.Header = 
    list: ->
      App.header.show new App.Views.Header()
