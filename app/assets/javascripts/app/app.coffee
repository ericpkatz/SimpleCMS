@App = new Marionette.Application()

App.addRegions
  main:   '#main'
  header: '#header'
  footer: '#footer'
  flash:  '#flash'



App.getPages = ()-> 
  App.DAL.Page.get()

App.getPage = (id, callback, bypass_cache = false) ->
  cache = App.Cache.api unless bypass_cache
  auth_promise = App.DAL.Auth.get() 
  page_promise = App.DAL.Page.getById(id, cache)
  $.when(auth_promise, page_promise).done (auth_data, page_data) ->
    callback page_data, auth_data?.role == 'admin'

App.vent.on 'PAGE:delete', (id)->
  App.DAL.Page.delete id, $("meta[name=csrf-token]").attr("content"), (data)-> 
    App.vent.trigger 'PAGE:change'
    App.vent.trigger 'PAGE:get', data.id
    App.vent.trigger 'FLASH:show', 'Page has been deleted'

App.vent.on 'PAGE:save', (model)->
  App.DAL.Page.save model, $("meta[name=csrf-token]").attr("content"), (data) ->
    App.vent.trigger 'CACHE:set', 'Page', data.id, data
    App.vent.trigger 'PAGE:change'
    App.vent.trigger 'PAGE:get', data.id
    App.vent.trigger 'FLASH:show', 'Page has been saved'

App.vent.on 'PAGE:get', (id)->
  if !id
    $.when(App.DAL.Auth.get(), App.DAL.Page.get(true)).done (auth_data, pages_data)->
      page_data = _.find(pages_data, (page)->page.is_home_page)
      App.vent.trigger 'PAGE:show', page_data, auth_data?.role == 'admin' 
  else
    App.getPage id, (data, admin = false)->
      App.vent.trigger 'PAGE:show', data, admin

App.vent.on 'ROUTER:navigate', (route)->
  App.router.navigate route

App.vent.on 'PAGE:change', ()->
  $.when(App.DAL.Auth.get(), App.DAL.Page.get(true)).done (auth_data, pages_data)->
    user = new App.Models.User auth_data if auth_data
    App.vent.trigger 'HEADER:list', user, pages_data

App.on 'start', ->

  App.router = new App.Routers.AppRouter()
  Backbone.history.start {pushState: true} 
  App.vent.trigger 'PAGE:change'
