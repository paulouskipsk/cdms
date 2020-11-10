class Document < ApplicationRecord
  include Searchable
  search_by :title

  belongs_to :department

  enum category: { declaration: 'declaration', certification: 'certification' }, _suffix: :category

  validates :category, inclusion: { in: Document.categories.values }
  validates :title, :front_text, :back_text, :department_id, presence: true

  def self.human_categories
    categories.each_with_object({}) do |(key, _value), obj|
      obj[I18n.t("enums.categories.#{key}")] = key
    end
  end
end
