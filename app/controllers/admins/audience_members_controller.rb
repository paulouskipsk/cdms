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

  def edit 
    @audience_member = AudienceMember.find(params[:id])
  end

  def update 
    audience_member = AudienceMember.find(audience_member_params[:id])
    audience_member.name = audience_member_params[:name]
    audience_member.email = audience_member_params[:email]
    audience_member.cpf = audience_member_params[:cpf]

    if audience_member.valid?
        audience_member.save
        flash[:success] = I18n.t('flash.actions.update.m', { resource_name: I18n.t('activerecord.models.audience_member.one') })
        redirect_to list_audience_members_path        
    else
      @audience_member = audience_member
      render :edit
    end
  end
  
  def destroy 
    audience_member = AudienceMember.find(params[:id])

    if audience_member.valid?
      audience_member.destroy
      flash[:success] = I18n.t('flash.actions.destroy.m', { resource_name: I18n.t('activerecord.models.audience_member.one') })
      redirect_to list_audience_members_path   
    else 
      flash[:error] = I18n.t('flash.not_found')
      redirect_to list_audience_members_path 
    end
    
  end
  

  private
    def audience_member_params
      params.require(:audience_member).permit(:id,:name, :email, :cpf)
    end
end
