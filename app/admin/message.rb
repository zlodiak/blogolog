ActiveAdmin.register Message do

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
    column :name
    column :title
    column :email
    column :created_at
    actions
  end

  filter :email
  filter :title
  filter :name
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :title
      f.input :body
      f.input :anon_author_name
      f.input :user_author_id
    end
    f.actions
  end  

  permit_params :title, :body, :email, :anon_author_name, :user_author_id

end
