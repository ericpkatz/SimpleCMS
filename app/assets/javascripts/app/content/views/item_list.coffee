App.module 'Content.Views', (Views, App)->
  Views.Item = Marionette.ItemView.extend
    template: JST['content/item']

  Views.List = Marionette.CompositeView.extend
    template: JST['content/list']
    itemView: Views.Item
    itemViewContainer: 'ul'
