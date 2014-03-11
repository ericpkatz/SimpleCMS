@App.module 'Controllers', (controllers, app, marionette, backbone, jquery, _) ->
  _deferred = null
  deferred = ->
    _deferred = _deferred || $.Deferred()

  promise = ->
    deferred().promise()

  API = 
    getPages: -> 
      app.getPages API.showList 
    showList: (pages)->
      app.header.show new App.Views.Header
        collection: new Backbone.Collection pages
    highlightPage: (id)->
      app.header.currentView.highlightPage(id)


  controllers.Header = 
    list: -> API.getPages()
    highlightPage: (id)->
      promise().done ->
        API.highlightPage(id)

  app.vent.on 'HEADER:list', ->
    controllers.Header.list()

  app.vent.on 'PAGE:show', (id) ->
    controllers.Header.highlightPage(id)

  app.vent.on 'HEADER:shown', () ->
    deferred().resolve()

  app.vent.on 'PAGE:change', (model)->
    _deferred = null
    controllers.Header.list()
