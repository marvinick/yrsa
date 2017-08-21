class Item < ApplicationRecord
  belongs_to :project, optional: true
end
