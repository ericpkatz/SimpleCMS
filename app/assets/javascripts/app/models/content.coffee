App.module 'Models', (Models, App)->
  Models.Content = Backbone.Model.extend
    defaults:
      priority: 5
    url: '/contents'
