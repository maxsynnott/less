ActiveAdmin.register Item do
  controller do
    skip_before_action :authenticate_user!
  end
  
  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :created_at
      row :updated_at
      row :image do |item|
        image_tag url_for(item.image) if item.image.attached?
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :store

      f.input :image, as: :file
    end

    f.actions
  end

  permit_params :name, :description, :price, :image, :store_id
end
