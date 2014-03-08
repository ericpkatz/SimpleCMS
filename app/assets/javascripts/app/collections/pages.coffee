App.module 'Collections', (collections, app) ->
  collections.Pages = Backbone.Collection.extend
    model: app.Models.Page
