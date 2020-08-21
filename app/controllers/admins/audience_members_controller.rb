class Admins::AudienceMembersController < ActionController::Base
  layout 'layouts/admins/application'

  def index
    @audience_members = AudienceMember.all
  end

  def new; 
    @audience_member = AudienceMember.new
  end

  def create
      audience_member = AudienceMember.new(audience_member_params)      

    if audience_member.valid?
      audience_member.save
      flash[:success] = I18n.t('flash.actions.create.m', { resource_name: I18n.t('activerecord.models.audience_member.one') })
      redirect_to list_audience_members_path
    else
      @audience_member = audience_member
      render :new
    end
  end

  private
    def audience_member_params
      params.require(:audience_member).permit(:name, :email, :cpf)
    end
end
