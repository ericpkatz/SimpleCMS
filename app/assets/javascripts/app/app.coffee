@App = new Marionette.Application()

App.addRegions
  main:   '#main'
  header: '#header'
  footer: '#footer'
  flash:  '#flash'

# '' - should grab a promise- if that promise is just created, then it should make the get request-
# the get request should resolve the deferred- this way it should only be called once.
router = Backbone.Router.extend
  routes:
    '' : ->
      _promise().done (data)->
      # App.getPages (data)->
        App.vent.trigger 'PAGE:show', _.find(data, (page)->page.is_home_page).id
    'pages/:id': (id) ->
      App.vent.trigger 'PAGE:show', id
    'pages/:id/edit': (id) ->
      App.vent.trigger 'NAV:show', id
      App.vent.trigger 'PAGE:edit', id
    'pages/:id/new': (id) ->
      App.vent.trigger 'PAGE:insert', id
      
App.router = new router()

_deferred = null

deferred = ()->
  if !_deferred
    _deferred = $.Deferred (d)->
      App.DAL.Page.get().done (data)->
        d.resolve data
  _deferred
    

_promise = ()->
  deferred().promise()

# DAL for page objects

App.vent.on 'PAGE:change', ()->
    _deferred = null

App.getPages = ()-> 
  _promise()

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
  App.vent.trigger 'HEADER:list'

$ ->
  App.start()

