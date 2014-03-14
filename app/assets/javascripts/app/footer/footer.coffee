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
      app.footer.show new app.Footer.Views.List
        collection: new Backbone.Collection pages
    highlightPage: (id)->
      app.footer.currentView.highlightPage(id)


  controllers.Footer = 
    list: -> API.getPages()
    highlightPage: (id)->
      promise().done ->
        API.highlightPage(id)

  app.vent.on 'HEADER:list', ->
    controllers.Footer.list()

  app.vent.on 'PAGE:show', (id) ->
    controllers.Footer.highlightPage(id)

  app.vent.on 'FOOTER:shown', () ->
    deferred().resolve()

  app.vent.on 'PAGE:change', (model)->
    _deferred = null
    controllers.Footer.list()
