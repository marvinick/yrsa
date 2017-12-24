module ProjectsHelper

  def project_reviewers
    reviewers = []
    @project.items.each do |item|
      item.reviews.each do |review|
        reviewers << review.user.email
      end
    end
    reviewers.uniq.count
  end

  def project_reviews_count
    @project.items.each do |item|
      return item.reviews.size
    end
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

  def all_items
    @project.items.count
  end

  def details_count
    each_item_details = []
    @project.items.each do |item|
      each_item_details << item.details.count
    end
    each_item_details.sum
  end

  def invitations
    invitations = []
    current_account.invitations.each do |invitation|
      invitations << invitation.email
    end
    invitations.uniq
  end

end
