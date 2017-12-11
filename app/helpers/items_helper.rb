module ItemsHelper

  def reviewers
    reviewers = []
    @item.reviews.each do |review|
      reviewers << review.user.email
    end
    reviewers.uniq
  end

  def all_reviewers
    reviewers.count
  end

  def total_reviews
    set_item.reviews.count
  end

  #real counting begin
  #calculate average rating for each review
  

  def item_average_rating
    item_rating / count_properties_names rescue 0
  end

  def count_properties_names
    names = []
    @item.reviews.each do |review|
      review.properties.each_key do |name|
        names << name
      end
    end
    names.uniq.size
  end

  def item_rating
    tar = []
    total_average_ratings = []
    total_rv = []
    @item.reviews.each do |review|
      review.properties.each do |name, value|
        total_rv << value.to_i
        total_average_ratings = total_rv.sum / total_rv.count
      end
    end
    tar << total_average_ratings
    tar.sum
  end

  #graph stats
  def count_values
    stars = []
    @item.reviews.each do |review|
      review.properties.each_value do |value|
        stars << value
      end
    end
    stars.size
  end

  def all_review_value
    stars = []
    @item.reviews.each do |review|
      review.properties.each_value do |value|
        stars << value
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
