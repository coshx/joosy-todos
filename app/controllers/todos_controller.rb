class TodosController < ApplicationController
  helper 'joosy/sprockets'

  def index
    render nothing: true, layout: 'todos'
  end
end
