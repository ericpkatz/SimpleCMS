@App = new Marionette.Application()

App.addRegions
  main: '#main'
  header: '#header'
  footer: '#footer'
  flash: '#flash'

router = Backbone.Router.extend
  routes:
    '' : ->
      App.getPages (data)->
        App.vent.trigger 'PAGE:show', _.find(data, (page)->page.is_home_page).id
    'pages/:id': (id) ->
      App.vent.trigger 'PAGE:show', id
    'pages/:id/edit': (id) ->
      App.vent.trigger 'NAV:show', id
      App.vent.trigger 'PAGE:edit', id
    'pages/:id/new': (id) ->
      App.vent.trigger 'PAGE:insert', id
      
App.router = new router()

App.cache = {}

App.getPages = (callback)-> 
  promise = $.get '/pages.json'
  promise.done (data) ->
    callback(data)

App.getPage = (id, callback, bypass_cache = false) ->
  key = "Page-#{id}"
  if bypass_cache
    App.cache[key] = null
  if App.cache[key]
    callback App.cache[key] 
  else
    promise = $.get "/pages/#{id}.json"
    promise.done (data) ->
      App.cache[key] = data
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

