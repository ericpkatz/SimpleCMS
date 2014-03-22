App.module 'Models', (models, app)->
  models.Page = Backbone.Model.extend
    isHomePage: ()->
      @get('is_home_page')
