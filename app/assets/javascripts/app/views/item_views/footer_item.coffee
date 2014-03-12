App.module "Views", (views, app) ->
  views.FooterItem = Backbone.Marionette.CompositeView.extend
    template: JST['footer/footer_item']
    tagName: 'li'
    events:
      'click a': ->
        app.vent.trigger 'PAGE:show', @model.get('id')
