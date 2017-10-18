module AccountsHelper
  def projects_in_account
    @account.projects.count
  end

  def items_in_project
    project_items = []
    @account.projects.each do |project|
      project_items << project.items.count
    end
    project_items.sum
  end

  def reviews_in_project
    project_reviews = []
    @account.projects.each do |project|
      project.items.each do |item|
        item.details.each do |detail|
          project_reviews << detail.reviews.count
        end
      end
    end
    project_reviews.sum
  end
end
