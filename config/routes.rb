# frozen_string_literal: true

Simpler.application.routes do
  get '/tests/:id', 'tests#show'
  get '/tests/:foo/x/:bar', 'tests#foobar'
  # get '/tests/:id/foo', 'tests#foo'
  get '/plain', 'tests#plain'
  get '/list', 'tests#list'
  post '/tests', 'tests#create'
end
