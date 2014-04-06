describe 'Page.Views.Form', ()->
  beforeEach ()->
    @view = new App.Page.Views.Form
      model: new App.Models.Page
    setFixtures @view.render().el

  describe 'Inserting', ()->
    it 'The default priority is set to 5', ()->
      expect(@view.ui.priority.val()).toEqual('5')

    describe 'Submitting', ()->

      describe 'Without a title', ()->
        beforeEach ()->
          spyOn App.vent, "trigger"
          $('[type=submit]').click()

        it 'Does not save the page', ()->
          expect(App.vent.trigger).not.toHaveBeenCalledWith('PAGE:save', @view.model)
        it 'Fires an error validation', ()->
          expect(App.vent.trigger).toHaveBeenCalledWith 'VALIDATION:error', 'PAGE', [@view.model.errorMessages.blankTitle]

      describe 'With a title with spaces', ()->
        beforeEach ()->
          @view.ui.title.val '        '
          spyOn App.vent, "trigger"
          $('[type=submit]').click()

        it 'Shows an error message', ()->
          expect(App.vent.trigger).not.toHaveBeenCalledWith('PAGE:save', @view.model)

        it 'Fires an error validation', ()->
          expect(App.vent.trigger).toHaveBeenCalledWith 'VALIDATION:error', 'PAGE', [@view.model.errorMessages.blankTitle]

      describe 'With a blank priority', ()->
        beforeEach ()->
          @view.ui.title.val 'abc'
          @view.ui.priority.val '        '
          spyOn App.vent, "trigger"
          $('[type=submit]').click()

        it 'Does not save', ()->
          expect(App.vent.trigger).not.toHaveBeenCalledWith('PAGE:save', @view.model)

        it 'Fires an error validation', ()->
          expect(App.vent.trigger).toHaveBeenCalledWith 'VALIDATION:error', 'PAGE', [@view.model.errorMessages.priority]

      describe 'With a non numeric priority', ()->
        beforeEach ()->
          @view.ui.title.val 'abc'
          @view.ui.priority.val 'x'
          spyOn App.vent, "trigger"
          $('[type=submit]').click()

        it 'Does not save', ()->
          expect(App.vent.trigger).not.toHaveBeenCalledWith('PAGE:save', @view.model)

        it 'Fires a non numeric event validation', ()->
          expect(App.vent.trigger).toHaveBeenCalledWith 'VALIDATION:error', 'PAGE', [@view.model.errorMessages.priority]
