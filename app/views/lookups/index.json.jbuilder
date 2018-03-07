json.array!(@pg_search_documents) do |pg_search|
  if pg_search.searchable.respond_to?(:title)
    json.title  pg_search.searchable.title
  end
end
