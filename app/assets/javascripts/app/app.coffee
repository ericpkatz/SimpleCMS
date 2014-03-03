@App = new Marionette.Application()

App.addRegions
  main: '#main'
  header: '#header'

router = Backbone.Router.extend
  routes:
    '' : ->
      alert 'TODO - need to load default page here'
      
App.appRouter = new router()


App.on 'start', ->

  Backbone.history.start {pushState: true} 

  App.Controllers.Header.list()


$ ->
  App.start()

