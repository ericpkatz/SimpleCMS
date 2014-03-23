App.module 'Models', (models, app)->
  models.User = Backbone.Model.extend
    urlRoot: '/auth/index'
