@App = new Marionette.Application()

App.addRegions
  main: '#main'
  header: '#header'

router = Backbone.Router.extend
  routes:
    '' : ->
      App.vent.trigger 'PAGE:show', 0
    'pages/:id': (id) ->
      App.vent.trigger 'PAGE:show', id
    'pages/:id/edit': (id) ->
      App.vent.trigger 'PAGE:edit', id
    'pages/:id/new': (id) ->
      App.vent.trigger 'PAGE:insert', id
      
App.router = new router()

App.cache = {}

App.getPages = (callback)-> 
  promise = $.get '/pages.json'
  promise.done (data) ->
    callback(data)

App.getPage = (id, callback) ->
  key = "Page-#{id}"
  if App.cache[key]
    callback App.cache[key] 
  else
    promise = $.get "/pages/#{id}.json"
    promise.done (data) ->
      App.cache[key] = data
      callback data

App.deletePage = (id) ->
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
      App.vent.trigger 'PAGE:change'
      App.vent.trigger 'PAGE:show', data.id

App.savePage = (page, callback) ->
  data = {page: page.toJSON()}
  data.authenticity_token = $("meta[name=csrf-token]").attr("content")
  if(page.isNew())
    promise = $.ajax(
      "/pages.json",
      {
        method: 'POST',
        data: data,
        dataType: 'json'
      }
    )
    promise.done (data) ->
      App.vent.trigger 'PAGE:change'
      App.vent.trigger 'PAGE:show', data.id
  else
    promise = $.ajax(
      "/pages/#{data.page.id}.json",
      {
        method: 'PATCH',
        data: data,
        dataType: 'json'
      }
    )
    promise.done (data) ->
      key = "Page-#{data.id}"
      App.cache[key] = data 
      App.vent.trigger 'PAGE:change'
      App.vent.trigger 'PAGE:show', data.id

App.on 'start', ->

  Backbone.history.start {pushState: true} 
  App.vent.trigger 'HEADER:list'


$ ->
  App.start()

