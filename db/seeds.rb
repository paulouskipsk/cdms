# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create_with(name: 'Administrador', password: '123456').find_or_create_by!(email: 'admin@admin.com')

role = Role.create_with(acronym: 'dir').find_or_create_by!(name: 'Diretor geral')
Role.create_with(acronym: 'adm').find_or_create_by!(name: 'Administrador assistente')

User.create_with(active: true, name: 'Administrador', register_number: '123', cpf: CPF.generate(true), role_id: role.id)
    .find_or_create_by!(username: 'admin')
