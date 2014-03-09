App.module 'Views', (views, app)->
  views.Page = Marionette.ItemView.extend
    template: JST['page/show']
    events:
      'click .edit': ->
        app.vent.trigger 'PAGE:edit', @model.get('id')
