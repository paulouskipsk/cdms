class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  include Searchable
  search_by :name

  before_destroy :can_destroy?

  has_many :department_users, dependent: :destroy
  has_many :departments, through: :department_users

  has_many :department_module_users, dependent: :destroy
  has_many :department_modules, through: :department_module_users

  belongs_to :role, optional: true

  validates :name, presence: true
  validates :register_number, presence: true
  validates :username, uniqueness: true, format: { with: /\A[a-z0-9_.]+\Z/ }
  validates_cpf_format_of :cpf, message: I18n.t('errors.messages.invalid')

  mount_uploader :avatar, AvatarUploader

  def username=(username)
    super(username)

    self.email = "#{username}@utfpr.edu.br"
  end

  def is?(role)
    return true if role.eql?(:admin) && self.role

    self.role&.identifier.eql?(role.to_s)
  end

  def last_manager?
    role = Role.find_by(identifier: :manager)

    is?(:manager) && role.users.count == 1
  end

  def can_destroy?
    return unless last_manager?

    errors.add :base, I18n.t('flash.actions.least', resource_name: Administrator.model_name.human)

    throw :abort
  end

  def member_of_any?
    departments.any?
  end

  def documents
    department_ids = departments.pluck(:id)
    Document.where(department_id: department_ids)
  end

  def self.admins
    includes(:role).where.not(role_id: nil)
  end

  def self.search_non_admins(term)
    where(role_id: nil).where('unaccent(name) ILIKE unaccent(?)', "%#{term}%").order('name ASC')
  end

  def departments_and_modules
    department_users.includes(:department).map do |dep_user|
      { 'modules' => populate_modules(dep_user.department.id),
        'department' => dep_user.department, 'role' => dep_user.role }
    end
  end

  private

  def populate_modules(department_id)
    department_module_users.includes(:department_module).map do |mod_user|
      next unless department_id == mod_user.department_module.department_id

      { 'role' => mod_user.role, 'module' => mod_user.department_module }
    end.compact
  end
end
