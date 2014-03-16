App.module 'Flash.Views', (views, app)->
  views.Show = Marionette.ItemView.extend 
    template: JST['flash/show']
    # initialize: (notice)->
      # alert notice
