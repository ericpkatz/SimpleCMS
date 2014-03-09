App.module "Views", (views, app) ->
  views.Header = Backbone.Marionette.CompositeView.extend
    itemViewContainer: 'ul'
    itemView: views.HeaderItem,
    template: JST['header/header']
    onShow: ->
      app.vent.trigger 'HEADER:shown'
    highlightPage: (id) ->
      @$el.find('li').removeClass('active')
      @$el.find("li a[data-id=#{id}]").parent().addClass('active')
