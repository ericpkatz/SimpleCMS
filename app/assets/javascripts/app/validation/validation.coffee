App.module 'Validation', (Validation, App)->

  App.vent.on 'VALIDATION:error', (sendTo, errors)->
    collection = new Backbone.Collection _.map errors, (item)->
      new Backbone.Model
        message: item
    view = new Validation.Views.Collection
      collection: collection
    App.vent.trigger "#{sendTo}:errors", view
