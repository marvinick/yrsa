module ItemsHelper

  def item_average_rating
    item_rating / @item.details.count rescue 0
  end

  def item_rating
    tar = []
    total_average_ratings = []
    total_rv = []
    @item.details.each do |detail|
      detail.reviews.each do |review|
        total_rv << review.value
        total_average_ratings = total_rv.sum / total_rv.count
      end
      tar << total_average_ratings
    end
    tar.sum
  end

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
