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

    @afterLoad ->
      @form = Joosy.Form.attach @newTodoForm,
        resource: @data.item
        success: => 
          @newTodoTitle.val('')
          @data.items.reload()
