App.module 'Models', (models, app)->
  models.Page = Backbone.Model.extend
    validate: (attrs)->
      alert 'hello world'
    isHomePage: ()->
      @get('is_home_page')
