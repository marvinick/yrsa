class Photo < ApplicationRecord
  include ImageUploader[:image]

  belongs_to :board
  belongs_to :item
  belongs_to :challenge
end
