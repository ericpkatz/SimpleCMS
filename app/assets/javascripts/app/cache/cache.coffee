App.module 'Cache', (cache, app)->
  cache.enabled = true
  cache.api =
    key: (prefix, id)->
      "#{prefix}-#{id}"
    store: {}
    getStore: ()->
      @store
    set: (prefix, id, value)->
      @store[@key prefix, id] = value
    clear: (prefix, id)->
      @store[@key prefix, id] = null 
    get: (prefix, id)->
      @store[@key prefix, id]

  cache.on 'CACHE:set', (prefix, id, value)->
    cache.api.set(prefix, id, value)
