require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('sinatra/activerecord')
require('./lib/task')
require('pg')

get('/') do
  @tasks = Task.all
  erb(:index)
end

