json.array!(@pg_search_documents) do |pg_search|
  if pg_search.searchable.class == Item
    json.id  pg_search.searchable.id
    json.name pg_search.searchable.name
    # json.url account_project_item_url(pg_search.searchable.account, pg_search.searchable.project, pg_search.searchable)
  elsif pg_search.searchable.class == Project
    json.id  pg_search.searchable.id
    json.name pg_search.searchable.title

    json.url account_project_url(pg_search.searchable.account, pg_search.searchable)
  elsif pg_search.searchable.class == Account
    json.name pg_search.searchable.name
    json.url root_url
  end
end
