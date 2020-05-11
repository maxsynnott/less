ActiveAdmin.register User do
  controller do
    skip_before_action :authenticate_user!
  end
  
  show do |user|
    attributes_table do
      User.column_names.each do |attribute|
        row attribute
      end

      row :masquerade do
        link_to "Masquerade", masquerade_admin_user_path(user), :target => '_blank'
      end

      active_admin_comments
    end
  end

  member_action :masquerade, method: :get do
    user = User.find(params[:id])
    bypass_sign_in user
    redirect_to root_path 
  end
end
