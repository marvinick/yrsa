class Project < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true
end
