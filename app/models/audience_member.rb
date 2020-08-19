class AudienceMember < ApplicationRecord
  validates :name, :cpf, :email, presence: true
  validates :name, length: { minimum: 2 }
  validates :email, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
end
