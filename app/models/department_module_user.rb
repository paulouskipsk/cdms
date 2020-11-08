class DepartmentModuleUser < ApplicationRecord
  before_save :link_user_in_department

  belongs_to :department_module
  belongs_to :user

  enum role: { responsible: 'responsible', collaborator: 'collaborator' }, _suffix: :role

  validates :role, inclusion: { in: DepartmentModuleUser.roles.values }
  validates :user, uniqueness: { scope: :department_module_id }
  validate :only_one_responsible, if: :responsible_role?

  def self.human_roles
    hash = {}
    roles.each_key { |key| hash[I18n.t("enums.roles.#{key}")] = key }
    hash
  end

  private

  def link_user_in_department
    return unless user_not_linked_department

    entity = DepartmentUser.new(department_id: department_module.department_id, user_id: user.id, role: :collaborator)
    entity.save
  end

  def user_not_linked_department
    DepartmentUser.includes(:department, :user)
                  .where(users: { id: user.id })
                  .where(departments: { id: department_module.department_id }).count.zero?
  end

  def only_one_responsible
    return if department_module.department_module_users.responsible_role.count.zero?

    errors.add(:role, I18n.t('errors.messages.taken'))
  end
end
