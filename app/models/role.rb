class Role < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :acronym, uniqueness: true, presence: true
end
