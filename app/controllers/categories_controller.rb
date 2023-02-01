class CategoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :active, :desactive]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash.now[:notice] = "Categoria cadastrada com sucesso."
      redirect_to categories_path
    else
      flash.now[:alert] = "Categoria não cadastrada."
      render 'new'
    end
  end

  def edit
  end

  def update

    if @category.update(category_params)
      flash[:notice] = 'Categoria atualizada com sucesso'
      redirect_to categories_path
    else
      flash.now[:alert] = "Não foi possível atualizar a categoria."
      render 'edit'
    end
  end

  def active
    @category.enable!
    redirect_to edit_category_path(@category)
  end

  def desactive
    @category.disable!
    redirect_to edit_category_path(@category)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
  
end