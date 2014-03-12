App.module "Views", (views, app) ->
  views.Footer = Backbone.Marionette.CompositeView.extend
    itemViewContainer: 'ul'
    itemView: views.FooterItem,
    template: JST['footer/footer']
    onShow: ->
      app.vent.trigger 'FOOTER:shown'
    highlightPage: (id) ->
      @$el.find('li').removeClass('active')
      @$el.find("li a[data-id=#{id}]").parent().addClass('active')
