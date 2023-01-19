class PricesController < ApplicationController

  before_action :set_price, only: [:edit, :update, :active, :desactive]

  def index
    @prices = Price.all
  end

  def new
    @price = Price.new
  end

  def create
    @price = Price.new(price_params)
    if @price.save
      flash.now[:notice] = "Preço cadastrado com sucesso."
      redirect_to categories_path
    else
      flash.now[:alert] = "Preço não cadastrada."
      render 'new'
    end
  end

  def edit
  end

  def update

    if @price.update(price_params)
      redirect_to prices_path, notice: 'Preço atualizado com sucesso'
    else
      flash.now[:alert] = "Não foi possível atualizar o preço."
      render 'edit'
    end
  end

  def set_price
    @price = Price.find(params[:id])
  end

  def price_params
    params.require(:price).permit(:min_weight, :max_weight, :km_price, :transporte_mode_id)
  end
  
end