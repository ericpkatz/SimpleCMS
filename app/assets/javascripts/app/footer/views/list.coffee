App.module "Footer.Views", (views, app) ->
  views.ListItem = Backbone.Marionette.CompositeView.extend
    template: JST['footer/footer_item']
    tagName: 'li'
    events:
      'click a': ->
        app.vent.trigger 'PAGE:show', @model.get('id')

  views.List = Backbone.Marionette.CompositeView.extend
    itemViewContainer: 'ul'
    itemView: views.ListItem,
    template: JST['footer/footer']
    onShow: ->
      app.vent.trigger 'FOOTER:shown'
    highlightPage: (id) ->
      @$el.find('li').removeClass('active')
      @$el.find("li a[data-id=#{id}]").parent().addClass('active')
