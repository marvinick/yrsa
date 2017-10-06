module ItemsHelper

  def total_reviews
    reviews = []
    @item.details.each do |detail|
      reviews << detail.reviews.count
    end
    reviews.sum
  end

  def all_review_value
    stars = []
    @item.details.each do |detail|
      detail.reviews.each do |review|
        stars << review.value
      end
    end
    stars
  end

  def each_review_value
    b = Hash.new(0)
    all_review_value.each do |v|
      b[v] += 1
    end
    b
  end

end
