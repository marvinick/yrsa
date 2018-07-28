module DetailsHelper

  def detail_route
    @project.details.each do |detail|
      edit_account_project_detail_path(current_account, @project, detail)
    end
  end

end
