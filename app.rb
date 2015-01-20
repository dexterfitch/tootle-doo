require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require("./lib/list")
require("pg")

DB = PG.connect({:dbname => "todo"})

get("/") do
  @lists = List.all()
  erb(:index)
end

post("/tasks") do
  description = params["description"]
  list_id = params["list_id"].to_i()
  task = Task.new({:description => description, :list_id => list_id})
  task.save()
  @list = List.find(list_id)
  erb(:list)
end

post("/lists") do
  name = params["name"]
  list = List.new({:name => name, :id => nil})
  list.save()
  @lists = List.all()
  erb(:index)
end

get("/lists/:id") do
  @list = List.find(params["id"].to_i())
  erb(:list)
end
