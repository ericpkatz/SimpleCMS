describe 'App.Collections.Contents', ()->
  beforeEach ()->
    @collection = new App.Collections.Contents [
      {
        title: 'hello'
      },
      {
        title: 'world'
      }
    ]

  it 'first models title is hello', ()->
    expect(@collection.first().get('title')).toEqual('hello')
  it 'first models priority is 5', ()->
    expect(@collection.first().get('priority')).toEqual 5
