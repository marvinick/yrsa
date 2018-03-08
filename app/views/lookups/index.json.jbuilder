json.array!(@pg_search_documents) do |pg_search|
  if pg_search.searchable.respond_to?(:name)
    json.id  pg_search.searchable.id
    json.name pg_search.searchable.name
    json.content pg_search.searchable.content
  else
    json.id  pg_search.searchable.id
    json.name pg_search.searchable.title
    json.content pg_search.searchable.description
  end
end
