App.module 'Validation', (Validation, App)->
  class Validation.Controller
    constructor: ()->
      App.vent.on 'VALIDATION:error', (sendTo, errors)=>
        @sendErrors sendTo, errors

    sendErrors: (sendTo, errors)->
      collection = new Backbone.Collection _.map errors, (item)->
        new Backbone.Model
          message: item
      view = new Validation.Views.Collection
        collection: collection
      App.vent.trigger "#{sendTo}:errors", view

  App.on 'start', ()->
    new Validation.Controller()
