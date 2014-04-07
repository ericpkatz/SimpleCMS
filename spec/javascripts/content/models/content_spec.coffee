describe 'App.Models.Content', ()->
  beforeEach ()->
    @model = new App.Models.Content()

  it "Exists", ()->
    expect(@model).not.toBeNull()
  it "Has a default priority", ()->
    console.log @model.get('priority')
    expect(@model.get('priority')).not.toBeUndefined()
