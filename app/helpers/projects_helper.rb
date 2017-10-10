module ProjectsHelper

  def project_item_average_rating
    project_item_rating
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
      tar.sum
    end
    tar
  end

end
