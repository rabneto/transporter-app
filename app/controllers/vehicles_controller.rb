class VehiclesController < ApplicationController

  before_action :set_vehicle, only: [:edit, :show, :update, :active, :desactive]

  def index
    if(params[:q]).present?
      @vehicles = Vehicle.where('plate like ?', "%#{params[:q]}%")
    else
      @vehicles = Vehicle.all
    end
  end

  def show; end

  def new
    @categories = Category.all
    @vehicle = Vehicle.new
  end

  def create
    @categories = Category.all
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      flash[:notice] = "Veículo cadastrado com sucesso."
      redirect_to @vehicle
    else
      flash.now[:alert] = "Veículo não cadastrado."
      render 'new'
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    @categories = Category.all
    if @vehicle.update(vehicle_params)
      flash[:notice] = 'Veículo atualizado com sucesso'
      redirect_to @vehicle
    else
      flash.now[:alert] = "Não foi possível atualizar o veículo."
      render 'edit'
    end
  end

  def active
    @vehicle.enable!
    redirect_to @vehicle
  end

  def desactive
    @vehicle.disable!
    redirect_to @vehicle
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:plate, :brand, :model, :year, :max_weight, :category_id)
  end
  
end