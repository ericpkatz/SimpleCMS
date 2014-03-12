@App.module 'Controllers', (controllers, app, marionette, backbone, jquery, _) ->
  _deferred = null
  deferred = ->
    _deferred = _deferred || $.Deferred()

  promise = ->
    deferred().promise()

  controllers.Header = 
    list: -> 
      app.getPages (pages)-> 
        app.header.show new App.Views.Header
          collection: new app.Collections.Pages pages
    highlightPage: (id)->
      promise().done ->
        app.header.currentView.highlightPage(id)

  app.vent.on 'HEADER:list', ->
    controllers.Header.list()

  app.vent.on 'PAGE:show', (id) ->
    controllers.Header.highlightPage(id)

  app.vent.on 'HEADER:shown', () ->
    deferred().resolve()

  app.vent.on 'PAGE:change', (model)->
    _deferred = null
    controllers.Header.list()
