class Review < ApplicationRecord
  belongs_to :detail, optional: true
end
