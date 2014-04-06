App.module 'Validation.Views', (Views, App)->
  Views.Item = Marionette.ItemView.extend
    template: JST['validation/item']
    tagName: 'li'

  Views.Collection = Marionette.CompositeView.extend
    template: JST['validation/collection']
    itemViewContainer: 'ul'
    itemView: Views.Item
