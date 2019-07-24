class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @careers = Career.where(category: @category)
  end


  private

  def set_category
    @category = Category.find(params[:id])

  end

end
