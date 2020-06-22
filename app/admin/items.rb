ActiveAdmin.register Item do
  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :created_at
      row :updated_at
      row :images do |item|
        ul do
          item.images.each do |image|
            li do
              image_tag url_for(image)
            end
          end
        end
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
