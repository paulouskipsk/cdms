require 'test_helper'

class AudienceMemberTest < ActiveSupport::TestCase
  subject { FactoryBot.build(:audience_member) }

  context 'validations' do
    should validate_presence_of(:name)
    should validate_uniqueness_of(:cpf).case_insensitive
    should validate_uniqueness_of(:email)

    context 'email' do
      should 'be a valid email' do
        valid_emails = ['pedro@utfpr.edu.br', 'pedro@gmail.com', 'teste@utfpr.edu.br']
        valid_emails.each do |valid_email|
          audience_member = FactoryBot.build(:audience_member, email: valid_email)
          assert audience_member.valid?
        end
      end

      should 'be an invalid email' do
        invalid_emails = ['not a email', 'pedrogonzaga.com', 'pedro@gonzagacom', 'pedro']
        invalid_emails.each do |invalid_email|
          audience_member = FactoryBot.build(:audience_member, email: invalid_email)
          assert_not audience_member.valid?
        end
      end
    end

    context 'cpf' do
      should 'be a valid cpf' do
        valid_cpf = ['047.593.909.36', '424.987.978-07']
        valid_cpf.each do |element|
          audience_member = FactoryBot.build(:audience_member, cpf: element)
          assert audience_member.valid?
        end
      end

      should 'be an invalid cpf' do
        invalid_cpf = ['111.111.111-11', 'aaa.aaa.aaa-aa', '047.593.909.37', '123.123.123-44']
        invalid_cpf.each do |element|
          audience_member = FactoryBot.build(:audience_member, cpf: element)
          assert_not audience_member.valid?
        end
      end
    end
  end
end