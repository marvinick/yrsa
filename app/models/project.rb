class Project < ApplicationRecord
  belongs_to :account

  def as_json(options={})
    super(methods: [:email])
  end

  def email
    author.email
  end
end
