require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload('lib/**/*.rb')

get('/') do
  @lists = List.all
  erb(:index)
end

get('/lists/:id/tasks/new') do
  @list = List.find(params.fetch('id').to_i())
  erb(:new_task)
end

get('/lists/new') do
  erb(:new_list)
end

get('/lists/:list_id/tasks/:id/edit') do
  @list = List.find(params.fetch('list_id').to_i())
  @task = Task.find(params.fetch('id').to_i())
  erb(:task_edit)
end

get('/lists/:id/edit') do
  @list = List.find(params.fetch('id').to_i())
  erb(:list_edit)
end

patch('/lists/:list_id/tasks/:id') do
  description = params.fetch('description')
  @task = Task.find(params.fetch('id').to_i)
  @task.update(description: description)
  @tasks = Task.all
  if @task.save
    redirect("/lists/".concat(params.fetch('list_id')))
  else
    erb(:errors)
  end
end

patch('/lists/:id') do
  name = params.fetch('name')
  @list = List.find(params.fetch('id').to_i)
  @list.update(name: name)
  @lists = List.all
  erb(:index)
end

get("/lists/:list_id/tasks/:id")do
  @task = Task.find(params.fetch('id').to_i())
  @list = List.find(params.fetch('list_id').to_i())
  erb(:task)
end

get("/lists/:id")do
  @list = List.find(params.fetch('id').to_i())
  @tasks = @list.tasks
  erb(:list)
end

post('/tasks') do
  list = List.find(params.fetch('list_id').to_i())
  @task = Task.new(description: params.fetch('description'), id: nil, done: false, list: list)
  @task.save
  if @task.save
    redirect("/lists/".concat(params.fetch('list_id')))
  else
    erb(:errors)
  end
end

post('/lists') do
  @list = List.new(name: params.fetch('name'), id: nil)
  @list.save
  if @list.save
    redirect("/lists/".concat(@list.id().to_s()))
  else
    erb(:errors)
  end
end
