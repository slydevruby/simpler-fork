# frozen_string_literal: true

# some
Simpler.application.routes do
  # get '/tests/:id', 'tests#show'
  # get '/tests/:id/foo', 'tests#foo'
  get '/plain', 'tests#plain'
  get '/lists', 'tests#list'
  post '/tests', 'tests#create'
end
