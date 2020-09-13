require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:acronym)
  end
end
