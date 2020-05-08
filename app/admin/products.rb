ActiveAdmin.register Product do
  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :created_at
      row :updated_at
      row :image do |product|
        image_tag url_for(product.image) if product.image.attached?
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price

      f.input :image, as: :file
    end

    f.actions
  end

  permit_params :name, :description, :price, :image
end