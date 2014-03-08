App.module "Views", (views, app) ->
  views.Header = Backbone.Marionette.CompositeView.extend
    itemViewContainer: 'ul'
    itemView: views.HeaderItem,
    template: JST['header/header']
