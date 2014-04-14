App.module 'Content', (Content)->

  class Content.Controller
    constructor: ()->
      App.vent.on 'CONTENT:edit', (model)=>
        @navigate 'ROUTER:navigate', "contents/#{model.get('id')}/edit"
        @edit model 
      App.vent.on 'CONTENT:delete', (model)=>
        @delete model 
      App.vent.on 'CONTENT:save', (model)=>
        @save model
    edit: (model)->
      App.main.show new Content.Views.Form( model: model)
    navigate: (name, path)->
      App.vent.trigger name, path 


    delete: (model)->
      model.destroy()
    save: (model)->


  App.on 'start', ()->
    new Content.Controller()
