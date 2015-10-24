ActiveAdmin.register SingleMeal do

  permit_params :title, :description, :price, :category_id

  form do |f|
    f.inputs "Meal" do
      f.input :title
      f.input :description, as: :text, required: false
      f.input :price
      f.input :category, collection: Category.pluck(:title, :id)
    end
    f.actions
  end
end
