App.module "Views", (views, app) ->
  views.Header = Backbone.Marionette.ItemView.extend
    template: JST['header']
