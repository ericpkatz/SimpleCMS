App.module 'Page.Views', (views, app)->
  views.Edit = Marionette.ItemView.extend
    template: JST['page/edit']
    ui:
      title: '#page_title'
      body: '#page_body'
      is_home_page: '#page_is_home_page'
    events: 
      'click .cancel': ->
        app.vent.trigger 'PAGE:get', @model.get('id')
      'click [type=submit]': ->
        @model.set 'title', @ui.title.val()
        @model.set 'body', @ui.body.val()
        @model.set 'is_home_page', @ui.is_home_page.is ':checked'
        app.vent.trigger 'PAGE:save', @model
        false
