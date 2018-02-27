json.array!(@pg_search_documents) do |pg_search_document|
  if pg_search_document.searchable.respond_to?(:title)
    json.title      pg_search_document.searchable.title
  elsif pg_search_document.searchable.respond_to?(:name)
    json.name       pg_search_document.searchable.name
  end
end
