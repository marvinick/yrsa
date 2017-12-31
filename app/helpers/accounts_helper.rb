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
        item.reviews.each do |review|
          project_reviews << review
        end
      end
    end
    project_reviews.count
  end
end
