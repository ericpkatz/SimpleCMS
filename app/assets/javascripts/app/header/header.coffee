@App.module 'Controllers', (controllers, app, marionette, backbone, jquery, _) ->
  _deferred = null
  deferred = ->
    _deferred = _deferred || $.Deferred()

  promise = ->
    deferred().promise()

  controllers.Header = 
    list: (user)-> 
      app.getPages().done (pages) -> 
        app.header.show new app.Header.Layouts.Nav
          navModel:
            collection: new app.Collections.Pages pages[1..-1]
            model: new app.Models.Page pages[0]
          authModel:
            model: user
    highlightPage: (id)->
      promise().done ->
        app.header.currentView.highlightPage(id)

  app.vent.on 'HEADER:list', (user) ->
    controllers.Header.list user

  app.vent.on 'PAGE:show', (id) ->
    controllers.Header.highlightPage(id)

  app.vent.on 'NAV:show', (id) ->
    controllers.Header.highlightPage(id)

  app.vent.on 'HEADER:shown', () ->
    deferred().resolve()

