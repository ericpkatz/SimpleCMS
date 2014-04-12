App.module 'Models', (models, app)->
  models.Page = Backbone.Model.extend
    errorMessages: 
      blankTitle: 'Title is required'
      priority: 'Priority is required and it must be a number'
    defaults: 
      priority: 5
    validate: (attrs)->
      errors = []
      blank_title = /^\s*$/.test attrs.title
      errors.push @errorMessages.blankTitle if blank_title 
      blank_priority = /^\s*$/.test attrs.priority
      numericPriority = /^\d*$/.test attrs.priority
      if blank_priority || !numericPriority
        errors.push @errorMessages.priority
      if _.isEmpty errors
        false
      else
        errors
    isHomePage: ()->
      @get('is_home_page')
    contents: ()->
      new App.Collections.Contents @get('contents')
