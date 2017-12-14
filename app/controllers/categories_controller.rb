class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  def new
    @category = Category.new
  end
  def edit
    @category = Category.find_by(params[:id])
  end
  def update
    category = category_params[:category]
    Category.update(category_params[:id], name: category[:name], description: category[:description])
    redirect_to categories_path
  end
  def create
    if Account.new(category_params[:category]).save
      redirect_to categories_path
    else
      redirect_to new_category_path
    end
  end

  def category_params
    params.permit(:id, category: [:name, :description])
  end
end
