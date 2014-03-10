App.module 'Views', (views, app)->
  views.PageInsert = Marionette.ItemView.extend
    template: JST['page/insert']
    ui:
      title: '#page_title'
      body: '#page_body'
    events: 
      'click [type=submit]': ->
        @model.set 'title', @ui.title.val()
        @model.set 'body', @ui.body.val()
        app.vent.trigger 'PAGE:save', @model
        false
