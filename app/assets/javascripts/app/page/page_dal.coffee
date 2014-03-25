App.module 'DAL', (dal, app) ->
  dal.Page = 
    get: ()->
      $.get('/pages.json').promise()
    getById: (id)->
      ($.get "/pages/#{id}.json").promise()
    save: (page, callback)->
      data = {page: page.toJSON()}
      data.authenticity_token = $("meta[name=csrf-token]").attr("content")

      promise = $.ajax(
        if page.isNew() then "/pages.json" else "/pages/#{data.page.id}.json"
        {
          method: if page.isNew() then "POST" else "PATCH" 
          data: data,
          dataType: 'json'
        }
      )
      promise.done (data) ->
        callback data
    delete: (id, callback)-> 
      data =
        authenticity_token : $("meta[name=csrf-token]").attr("content")
      promise = $.ajax(
        "/pages/#{id}",
        {
          method: 'DELETE',
          data: data,
          dataType: 'json'
        }
      )
      promise.done (data)->
        callback data

  dal.Auth = 
    get: ()->
      $.get('/auth/index').promise()

