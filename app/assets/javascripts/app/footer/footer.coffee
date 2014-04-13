App.module 'Footer', (Footer, app, marionette, backbone, jquery, _) ->

  class Footer.Controller 
    constructor: ()->
      @_deferred = null
      app.vent.on 'HEADER:list', (user, pages) =>
        @list(pages)

      app.vent.on 'PAGE:show', (model) =>
        @highlightPage(model.id)

      app.vent.on 'NAV:show', (id) =>
        @highlightPage(id)

      app.vent.on 'FOOTER:shown', () =>
        @deferred().resolve()

      app.vent.on 'PAGE:change', (model)->
        @_deferred = null
    list: (pages)-> 
      app.footer.show new app.Footer.Views.List
        collection: new Backbone.Collection pages
    highlightPage: (id)->
      @promise().done ->
        app.footer.currentView.highlightPage(id)
    deferred : ->
      @_deferred = @_deferred || $.Deferred()
    promise : ->
      @deferred().promise()

  App.on 'start', ()->
    new Footer.Controller()
