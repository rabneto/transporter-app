class PricesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_price, only: [:edit, :update, :destroy]

  def index
    @prices = Price.includes(:transport_mode).order(transport_mode_id: :asc, min_weight: :asc).all
  end

  def new
    @transport_modes = TransportMode.order(name: :asc).all
    @price = Price.new
  end

  def create
    @transport_modes = TransportMode.all
    @price = Price.new(price_params)
    if !params[:price][:km_price].empty?
      @price.km_price = params[:price][:km_price].gsub(",",".").to_f
    end
    if @price.save
      flash[:notice] = "Preço cadastrado com sucesso."
      redirect_to prices_path
    else
      flash.now[:alert] = "Preço não cadastrado."
      render 'new'
    end
  end

  def edit
    @transport_modes = TransportMode.all
  end

  def update
    @transport_modes = TransportMode.all
    if !params[:price][:km_price].empty?
      @price.km_price = params[:price][:km_price].gsub(",",".").to_f
    end
    if @price.update(price_params)
      flash[:notice] = "Preço atualizado com sucesso."
      redirect_to prices_path
    else
      flash.now[:alert] = "Não foi possível atualizar o preço."
      render 'edit'
    end
  end

  def destroy
    @price.destroy
    flash[:alert] = "Preço removido com sucesso."
    redirect_to prices_path
  end

  private

  def set_price
    @price = Price.find(params[:id])
  end

  def price_params
    params.require(:price).permit(:min_weight, :max_weight, :km_price, :transport_mode_id)
  end
  
end