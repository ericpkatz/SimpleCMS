@App.module 'Controllers', (controllers, app, marionette, backbone, jquery, _) ->
  _deferred = null
  deferred = ->
    _deferred = _deferred || $.Deferred()

  promise = ->
    deferred().promise()


  controllers.Footer = 
    list: (pages)-> 
      app.footer.show new app.Footer.Views.List
        collection: new Backbone.Collection pages
    highlightPage: (id)->
      promise().done ->
        app.footer.currentView.highlightPage(id)

  app.vent.on 'HEADER:list', (user, pages) ->
    controllers.Footer.list(pages)

  app.vent.on 'PAGE:show', (model) ->
    controllers.Footer.highlightPage(model.id)

  app.vent.on 'NAV:show', (id) ->
    controllers.Footer.highlightPage(id)

  app.vent.on 'FOOTER:shown', () ->
    deferred().resolve()

  app.vent.on 'PAGE:change', (model)->
    _deferred = null
