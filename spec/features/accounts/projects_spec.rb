require "rails_helper"

feature "Projects" do
  let!(:account_a) { FactoryGirl.create(:account) }
  let!(:account_b) { FactoryGirl.create(:account) }

  before do
    FactoryGirl.create(:project, title: "Account A's project", account: account_a )
    FactoryGirl.create(:project, title: "Account B's project", account: account_b )
  end

  context "index" do
    scenario "displays only account A's project" do
      login_as(account_a.owner)
      visit root_url
      visit account_path(account_a)
      expect(page).to have_content("Account A's project")
      expect(page).to_not have_content("Account B's project")
    end

    scenario "displays only account B's project" do
      login_as(account_b.owner)
      visit root_url
      visit account_path(account_b)
      expect(page).to have_content("Account B's project")
      expect(page).to_not have_content("Account A's project")
    end
  end

  context "show" do
    context "when signed in as account A's owner" do
      before do
        login_as(account_a.owner)
      end

      it "can see Account A's project" do
        project = account_a.projects.last
        visit root_url
        visit account_path(account_a)
        visit account_project_path(account_a, project)
        expect(page).to have_content(project.title)
      end

      it "cannot see account B's project" do
        project = account_b.projects.first
        visit root_url
        visit account_path(account_b)
        visit account_project_url(account_b, project)
        expect(page).to have_content("Project not found.")
        expect(page.current_url).to eq(root_url)
      end
    end
  end
end
