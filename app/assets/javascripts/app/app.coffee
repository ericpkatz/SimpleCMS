@App = new Marionette.Application()

App.addRegions
  main:   '#main'
  header: '#header'
  footer: '#footer'
  flash:  '#flash'

      

_deferredPages = null

deferredPages = ()->
  if !_deferredPages
    _deferredPages = $.Deferred (d)->
      App.DAL.Page.get().done (data)->
        d.resolve data
  _deferredPages

_promisePages = ()->
  deferredPages().promise()

_deferredAuth = null

deferredAuth = ()->
  if !_deferredAuth
    _deferredAuth = $.Deferred (d)->
      App.DAL.Auth.get().done (data)->
        d.resolve data
  _deferredAuth

_promiseAuth = ()->
  deferredAuth().promise()

# DAL for page objects

App.vent.on 'PAGE:change', ()->
    _deferredPages = null

App.getPages = ()-> 
  _promisePages()

App.getPage = (id, callback, bypass_cache = false) ->
  _promiseAuth().done (data)->
    user = new App.Models.User data if data
    admin = user && user.get('role') == 'admin'
    if App.Cache.api.get('Page', id) && App.Cache.enabled && !bypass_cache
      callback App.Cache.api.get('Page', id), admin
    else
      App.DAL.Page.getById(id).done (data) ->
        App.Cache.api.set('Page', id,data)
        callback data, admin

App.deletePage = (id, callback) ->
  App.DAL.Page.delete id, callback

App.savePage = (page, callback) ->
  App.DAL.Page.save page, callback

App.vent.on 'ROUTER:navigate', (route)->
  App.router.navigate route

App.vent.on 'PAGE:change', ()->
  _promiseAuth().done (data)->
    user = new App.Models.User data if data
    App.vent.trigger 'HEADER:list', user

App.on 'start', ->

  App.router = new App.Routers.AppRouter
    promisePages: _promisePages 
  Backbone.history.start {pushState: true} 
  _promiseAuth().done (data)->
    user = new App.Models.User data if data
    App.vent.trigger 'HEADER:list', user

