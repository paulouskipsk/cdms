class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  belongs_to :role, optional: true

  before_destroy :can_unlink_administrator?, prepend: true

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :register_number, presence: true
  validates :username, uniqueness: true, format: { with: /\A[a-z0-9]+\Z/ }
  validates_cpf_format_of :cpf, message: I18n.t('errors.messages.invalid')

  def username=(username)
    super(username)

    self.email = "#{username}@utfpr.edu.br"
  end

  def can_unlink_administrator?
    role = Role.find_by('acronym': 'dir')
    return true if role.nil?

    throw :abort if role_id == role.id && User.where('role_id': role.id).count == 1
  end
end
