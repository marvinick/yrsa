module ProjectsHelper

  def project_reviewers
    reviewers = []
    @project.items.each do |item|
      item.details.each do |detail|
        detail.reviews.each do |review|
          reviewers << review.user.email
        end
      end
    end
    reviewers.uniq.count
  end

  def project_rating
    each_detail = []
    @project.items.each do |item|
      item.details.each do |detail|
        detail.reviews.each do |review|
          each_detail << review.value
        end
      end
    end
    (each_detail.sum / each_detail.count.to_f).ceil rescue 0
  end

  def project_reviews_count
    reviews = []
    @project.items.each do |item|
      item.details.each do |detail|
        reviews << detail.reviews.count
      end
    end
    reviews
  end

  def details_count
    each_item_details = []
    @project.items.each do |item|
      each_item_details << item.details.count
    end
    each_item_details.sum
  end

  def all_items
    @project.items.count
  end

end
