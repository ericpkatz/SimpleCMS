App.module 'DAL', (dal, app) ->
  dal.Page = 
    get: ()->
      $.get('/pages.json').promise()
    getById: (id)->
      ($.get "/pages/#{id}.json").promise()

