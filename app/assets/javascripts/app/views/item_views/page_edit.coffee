App.module 'Views', (views, app)->
  views.PageEdit = Marionette.ItemView.extend
    template: JST['page/edit']
    ui:
      title: '#page_title'
      body: '#page_body'
    events: 
      'click .cancel': ->
        app.vent.trigger 'PAGE:show', @model.get('id')
      'click [type=submit]': ->
        @model.set 'title', @ui.title.val()
        @model.set 'body', @ui.body.val()
        app.vent.trigger 'PAGE:save', @model
        false
        # app.vent.trigger 'PAGE:show', @model.get('id')
