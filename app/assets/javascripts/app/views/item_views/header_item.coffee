App.module "Views", (views, app) ->
  views.HeaderItem = Backbone.Marionette.CompositeView.extend
    template: JST['header/header_item']
    tagName: 'li'
    events:
      'click a': ->
        app.vent.trigger 'PAGE:show', @model.get('id')
