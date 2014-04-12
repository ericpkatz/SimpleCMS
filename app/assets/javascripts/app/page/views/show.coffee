App.module 'Page.Views', (views, app)->
  views.Show = Marionette.ItemView.extend
    initialize: (options)->
    ui :
      deleteModal: '#myModal'
    template: JST['page/show']
    events:
      'click .edit': ->
        app.vent.trigger 'PAGE:edit', @model.get('id')
      'click .insert': ->
        app.vent.trigger 'PAGE:insert', @model.get('id')
      'click .delete': ->
         @ui.deleteModal.promise().done ()=>
           $('.modal-backdrop').remove()
           $('body').removeClass('.modal-open')
           app.vent.trigger 'PAGE:delete', @model.get('id')
