App.module 'Routers', (routers, app) ->
  routers.AppRouter = Backbone.Router.extend
    initialize: (options)->
      @promisePages = options.promisePages
    routes:
      '' : ->
        @promisePages().done (data)->
          App.vent.trigger 'PAGE:show', _.find(data, (page)->page.is_home_page).id
      'pages/:id': (id) ->
        App.vent.trigger 'PAGE:show', id
      'pages/:id/edit': (id) ->
        App.vent.trigger 'NAV:show', id
        App.vent.trigger 'PAGE:edit', id
      'pages/:id/new': (id) ->
        App.vent.trigger 'PAGE:insert', id

