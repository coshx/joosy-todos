Joosy.namespace 'Items', ->

  class @IndexPage extends ApplicationPage
    @layout ApplicationLayout
    @view   'index'

    @fetch (complete) ->
      Item.find 'all', (items) =>
        @data.items = items
        @data.item = Item.build()
        complete()

    elements:
      'newTodoForm': '#new-todo-form'
      'newTodoTitle': '#new-todo'
      'destroyButton': 'button.destroy'
      'completeToggle': 'input.toggle'

    events:
      'click $destroyButton': (element) ->
        @data.items.findById($(element).data('id')).delete({})
        @data.items.reload()
        true
      'change $completeToggle': (element) ->
        item = @data.items.findById($(element).data('id'))
        completed = $(element).prop('checked')
        item('completed', completed)
        item.put({})
        true

    @afterLoad ->
      @form = Joosy.Form.attach @newTodoForm,
        resource: @data.item
        success: => 
          @newTodoTitle.val('')
          @data.items.reload()
