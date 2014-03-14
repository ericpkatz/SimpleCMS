App.module "Header.Views", (views, app) ->
  views.ListItem = Backbone.Marionette.CompositeView.extend
    template: JST['header/header_item']
    tagName: 'li'
    events:
      'click a': ->
        app.vent.trigger 'PAGE:show', @model.get('id')

  views.List = Backbone.Marionette.CompositeView.extend
    itemViewContainer: 'ul'
    itemView: views.ListItem,
    template: JST['header/header']
    onShow: ->
      app.vent.trigger 'HEADER:shown'
    highlightPage: (id) ->
      @$el.find('li').removeClass('active')
      @$el.find("li a[data-id=#{id}]").parent().addClass('active')
