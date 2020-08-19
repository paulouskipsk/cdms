require 'test_helper'

class AudienceMemberTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:email)
    should validate_presence_of(:cpf)
  end

  context 'email regex' do
    should 'be a valid email' do
      audience_member = FactoryBot.build(:audience_member)
      assert audience_member.valid?

      audience_member = FactoryBot.build(:audience_member, email: 'pedro@utfpr.edu.br')
      assert audience_member.valid?

      audience_member = FactoryBot.build(:audience_member, email: 'pedro@gmail.com')
      assert audience_member.valid?
    end

    should 'be an invalid email' do
      audience_member = FactoryBot.build(:audience_member, email: 'not a email')
      assert_not audience_member.valid?

      audience_member = FactoryBot.build(:audience_member, email: 'pedrogonzaga.com')
      assert_not audience_member.valid?

      audience_member = FactoryBot.build(:audience_member, email: 'pedro@gonzagacom')
      assert_not audience_member.valid?

      audience_member = FactoryBot.build(:audience_member, email: 'pedro @gonzaga.com')
      assert_not audience_member.valid?
    end
  end
end
