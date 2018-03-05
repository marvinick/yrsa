json.array! @projects do |project|
  json.id project.id
  json.title project.title
  json.description project.description
end
