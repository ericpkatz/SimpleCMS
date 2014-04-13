App.module 'Flash', (flash, app, b, u, m, $)->
  class flash.Controller
    constructor: ()->
      app.vent.on 'FLASH:show', (notice) =>
        @show notice
    show: (notice)->
      app.flash.show new flash.Views.Show 
        model: new Backbone.Model
          notice: notice 

  App.on 'start', ()->
    new App.Flash.Controller() 
