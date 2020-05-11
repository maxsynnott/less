ActiveAdmin.register ActiveAdmin::Comment, as: 'Comment' do
  controller do
    skip_before_action :authenticate_user!
  end
end