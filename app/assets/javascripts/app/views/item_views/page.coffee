App.module 'Views', (views, app)->
  views.Page = Marionette.ItemView.extend
    template: JST['page/show']
