module DetailsHelper

  def reviewers
    reviewers = []
    @detail.reviews.each do |review|
      reviewers << review.user.email
    end
    reviewers.uniq.count
  end

end
