App.module 'Content.Views', (Views, App)->
  Views.Item = Marionette.ItemView.extend
    initialize: (options)->
      @admin = options.admin
    template: JST['content/item']
    serializeData: ()->
      model: @model
      admin: @admin

  Views.List = Marionette.CompositeView.extend
    initialize: (options)->
      @admin = options.admin
    template: JST['content/list']
    itemView: Views.Item
    itemViewContainer: 'ul'
    itemViewOptions: ()->
      admin: @admin 
    serializeData: ()->
      admin: @admin
