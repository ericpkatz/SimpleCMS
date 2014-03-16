App.module 'Flash', (flash, app, b, u, m, $)->
  app.vent.on 'FLASH:show', (notice) ->
    app.flash.show new flash.Views.Show 
      model: new Backbone.Model
        notice: notice 
