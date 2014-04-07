App.module 'Collections', (Collections, App)->
  Collections.Contents = Backbone.Collection.extend
    model: App.Models.Content
