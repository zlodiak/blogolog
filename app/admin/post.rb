ActiveAdmin.register Post do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  index do
    selectable_column
    id_column
    column :title
    column :user
    column :created_at
    column :updated_at
    actions
  end

  filter :title
  filter :user_id
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :title
      f.input :body
      f.input :user     
    end
    f.actions
  end  

end
