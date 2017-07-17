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

get('/tasks/new') do
  erb(:new_task)
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch('id').to_i)
  erb(:task_edit)
end

patch('/tasks/:id') do
  description = params.fetch('description')
  @task = Task.find(params.fetch('id').to_i)
  @task.update(description: description)
  @tasks = Task.all
  erb(:index)
end

post('/tasks') do
  @task = Task.new(description:params.fetch('description'),id:nil,done:false)
  @task.save()
  if @task.save()
    erb(:success)
  else
    erb(:errors)
  end
end
