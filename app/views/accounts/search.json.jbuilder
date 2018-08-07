json.projects do
  json.array!(@projects) do |project|
    json.title project.title
    json.url account_project_path(@account, project)
  end
end

json.items do
  json.array!(@items) do |item|
    json.name item.name
    json.url account_project_item_path(@account, @project, item)
  end
end
