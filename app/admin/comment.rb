ActiveAdmin.register Comment, as: "PostComment" do
  index do
    selectable_column
    id_column
    column :body
    column :user
    column :post
    actions
  end

  filter :body
  filter :user
  filter :post
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :body   
      f.input :user   
      f.input :post   
      f.input :ancestry   
    end
    f.actions
  end 

  permit_params :body, :user_id, :post_id

end
