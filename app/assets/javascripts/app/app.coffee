@App = new Marionette.Application()

App.addRegions
  main:   '#main'
  header: '#header'
  footer: '#footer'
  flash:  '#flash'

router = Backbone.Router.extend
  routes:
    '' : ->
      _promisePages().done (data)->
        App.vent.trigger 'PAGE:show', _.find(data, (page)->page.is_home_page).id
    'pages/:id': (id) ->
      App.vent.trigger 'PAGE:show', id
    'pages/:id/edit': (id) ->
      App.vent.trigger 'NAV:show', id
      App.vent.trigger 'PAGE:edit', id
    'pages/:id/new': (id) ->
      App.vent.trigger 'PAGE:insert', id
      
App.router = new router()

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
  if App.Cache.api.get('Page', id) && App.Cache.enabled && !bypass_cache
    callback App.Cache.api.get('Page', id) 
  else
    App.DAL.Page.getById(id).done (data) ->
      App.Cache.api.set('Page', id,data)
      callback data

App.deletePage = (id, callback) ->
    data =
      authenticity_token : $("meta[name=csrf-token]").attr("content")
    promise = $.ajax(
      "/pages/#{id}",
      {
        method: 'DELETE',
        data: data,
        dataType: 'json'
      }
    )
    promise.done (data)->
      callback data

App.savePage = (page, callback) ->
  data = {page: page.toJSON()}
  data.authenticity_token = $("meta[name=csrf-token]").attr("content")

  promise = $.ajax(
    if page.isNew() then "/pages.json" else "/pages/#{data.page.id}.json"
    {
      method: if page.isNew() then "POST" else "PATCH" 
      data: data,
      dataType: 'json'
    }
  )
  promise.done (data) ->
    callback data

App.on 'start', ->

  Backbone.history.start {pushState: true} 
  _promiseAuth().done (data)->
    user = new App.Models.User data if data
    App.vent.trigger 'HEADER:list', user

$ ->
  App.start()
