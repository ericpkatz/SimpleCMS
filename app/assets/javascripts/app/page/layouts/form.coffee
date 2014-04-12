App.module 'Page.Views', (Views, App)->
  Views.FormLayout = Marionette.Layout.extend
    regions:
      validationErrors: '#validation-errors',
      form: '#form'
    initialize: (options)->
      @page = options.page
      App.vent.on 'PAGE:errors', (view)=>
        @validationErrors.show view
    template: JST['page/form_layout']
    onRender: ()->
      @form.show new Views.Form
        model: @page

