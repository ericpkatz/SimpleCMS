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
      
App.router = new router()

App.getPages = (callback)-> 
  promise = $.get '/pages.json'
  promise.done (data) ->
    callback(data)

App.getPage = (id, callback) ->
  promise = $.get "/pages/#{id}.json"
  promise.done (data) ->
    callback data

App.on 'start', ->

  Backbone.history.start {pushState: true} 
  App.vent.trigger 'HEADER:list'


$ ->
  App.start()

