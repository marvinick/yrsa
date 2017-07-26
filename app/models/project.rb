class Project < ApplicationRecord
  belongs_to :author, class_name: "User"

  def as_json(options={})
    super(methods: [:email])
  end

  def email
    author.email
  end
end
