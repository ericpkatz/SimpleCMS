App.module 'Header.Layouts', (layouts, app)->
  layouts.Nav = Marionette.Layout.extend
    template: JST["header/header"]
    regions:
      nav: '#nav'
      auth: '#auth'
      brand: '#brand'
    initialize: (options)->
      @navModel= options.navModel
      @authModel = options.authModel
    onShow: ()->
      @nav.show new app.Header.Views.List 
        collection: @navModel.collection 

      @brand.show new app.Header.Views.Brand
        model: @navModel.model
      @auth.show new app.Header.Views.Auth
        model: @authModel.model
    highlightPage: (id)->
      @nav.currentView.highlightPage id

