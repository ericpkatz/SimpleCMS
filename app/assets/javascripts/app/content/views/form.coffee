App.module 'Content.Views', (Views)->
  class Views.Form extends Marionette.ItemView
    template: JST['content/form']
    ui:
      title : '#content_title'
      body : '#content_body'
      priority : '#content_priority'
      submit: 'button[type=submit]'
    events:
      'click button[type=submit]': ()-> @save() 
    save: ()->
      App.vent.trigger 'CONTENT:save', @model
