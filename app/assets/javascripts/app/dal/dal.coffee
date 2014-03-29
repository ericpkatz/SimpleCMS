App.module 'DAL', (dal, app) ->

  _deferredPages = null

  dal.Page = 
    get: (reset = false)->
      _deferredPages = null if reset
      if !_deferredPages
        _deferredPages = $.Deferred (d)->
          $.get('/pages.json').done (data)->
            d.resolve data

      _deferredPages.promise()

    getById: (id, cache)->
      ($.Deferred (d)->
        if cache && cache.get('Page', id)
          d.resolve cache.get('Page', id)
        else
          ($.get "/pages/#{id}.json").done (data)->
            cache.set('Page', id, data) if cache
            d.resolve data

      ).promise()


    save: (page, auth_token, callback)->
      data = {page: page.toJSON()}
      data.authenticity_token = auth_token 

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
    delete: (id, auth_token, callback)-> 
      data =
        authenticity_token : auth_token 
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

  _deferredAuth = null

  dal.Auth = 
    get: ()->
      if !_deferredAuth
        _deferredAuth = $.Deferred (d)->
          $.get('/auth/index').done (data)->
            _deferredAuth.resolve data
      _deferredAuth.promise()

