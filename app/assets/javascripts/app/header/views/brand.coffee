App.module "Header.Views", (views, app) ->
  views.Brand = Backbone.Marionette.ItemView.extend
    template: JST['header/brand']
    tagName: 'span'
    serializeData: ()->
      model: @model.toJSON()
    events:
      'click a.navbar-brand': ->
        app.vent.trigger 'PAGE:show', @model.get('id')
        false
