App.module "Header.Views", (views, app) ->
  views.ListItem = Backbone.Marionette.ItemView.extend
    template: JST['header/nav_item']
    tagName: 'li'
    events:
      'click a': ->
        app.vent.trigger 'PAGE:show', @model.get('id')
        false

  views.List = Backbone.Marionette.CompositeView.extend
    initialize: (options)->
    itemViewContainer: 'ul'
    itemView: views.ListItem,
    template: JST['header/nav']
    onShow: ->
      app.vent.trigger 'HEADER:shown'
    highlightPage: (id) ->
      @$el.find('li').removeClass('active')
      @$el.find("li a[data-id=#{id}]").parent().addClass('active')
