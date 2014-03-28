App.module 'Flash', (flash, app, b, u, m, $)->
  flash.Controller =
    show: (notice)->
      app.flash.show new flash.Views.Show 
        model: new Backbone.Model
          notice: notice 

  app.vent.on 'FLASH:show', (notice) ->
    flash.Controller.show notice
