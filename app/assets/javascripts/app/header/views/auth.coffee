App.module "Header.Views", (views, app) ->
  views.Auth = Backbone.Marionette.ItemView.extend
    template: JST['header/auth']
    tagName: 'span'
