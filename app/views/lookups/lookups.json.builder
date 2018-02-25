json.array!(@lookups) do |lookup|
  json.name           book.title
  json.description    book.author
  json.content        number_to_currency(book.price)
  json.title
  json.published_at book.published_at.strftime('%B %Y')
  json.image_url    book.image_url
end
