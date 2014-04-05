App.module 'Models', (models, app)->
  models.Page = Backbone.Model.extend
    defaults: 
      priority: 5
    validate: (attrs)->
      # alert 'hello world'
    isHomePage: ()->
      @get('is_home_page')
