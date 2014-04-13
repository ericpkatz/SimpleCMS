@App.module 'Header', (Header, app, marionette, backbone, jquery, _) ->

  class Header.Controller
    constructor: ()->
      @_deferred = null
      
      app.vent.on 'HEADER:list', (user, pages) =>
        @list user, pages

      app.vent.on 'PAGE:show', (model) =>
        @highlightPage(model.id)

      app.vent.on 'PAGE:change', () =>
        @_deferred = null

      app.vent.on 'NAV:show', (id) =>
        @highlightPage(id)

      app.vent.on 'HEADER:shown', () =>
        @deferred().resolve()


    list: (user, pages)-> 
      app.header.show new app.Header.Layouts.Nav
        navModel:
          collection: new app.Collections.Pages pages[1..-1]
          model: new app.Models.Page pages[0]
        authModel:
          model: user
    highlightPage: (id)->
      @promise().done ->
        app.header.currentView.highlightPage(id)
    deferred : ->
      @_deferred = @_deferred || $.Deferred()
    promise : ->
      @deferred().promise()

  App.on 'start', ()->
    new Header.Controller()
