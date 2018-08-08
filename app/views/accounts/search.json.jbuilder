json.accounts do
  json.array!(@accounts) do |account|
    json.name account.name

    json.projects do

      json.array!(@projects) do |project|

        json.title project.id
        json.url account_project_path(account, project)

        # json.items do
        #   json.array!(@items) do |item|
        #     json.name item.name
        #     json.url account_project_item_path(account, project, item)
        #   end
        # end
      end
    end
  end
end
