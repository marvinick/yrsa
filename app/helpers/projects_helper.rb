module ProjectsHelper

  def all_items
    @project.items.count
  end

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
    ratings.sum / @project.items.count
  end

  def ratings
    ratings = []
    @project.items.each do |item|
      ratings << project_item_rating / item.details.count rescue 0
    end
    ratings
  end

  def project_item_rating
    tar = []
    total_average_ratings = []
    total_rv = []
    @project.items.each do |item|
      item.details.each do |detail|
        detail.reviews.each do |review|
          total_rv << review.value
          total_average_ratings = total_rv.sum / total_rv.count
        end
        tar << total_average_ratings
      end
    end
    tar.sum
  end

end
