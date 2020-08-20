class Admins::AudienceMembersController < ActionController::Base
  layout 'layouts/admins/application'

  def index
    @audience_members = AudienceMember.all
  end
end
