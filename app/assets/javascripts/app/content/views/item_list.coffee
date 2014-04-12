App.module 'Content.Views', (Views, App)->
  _admin = false
  Views.Item = Marionette.ItemView.extend
    initialize: (options)->
    template: JST['content/item']

  Views.List = Marionette.CompositeView.extend
    initialize: (options)->
      _admin = options.admin
    template: JST['content/list']
    itemView: Views.Item
    itemViewContainer: 'ul'
    isAdmin: ()->
      _admin
    itemViewOptions:
      admin: _admin 
