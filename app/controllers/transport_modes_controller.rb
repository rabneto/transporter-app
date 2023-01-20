class TransportModesController < ApplicationController

  before_action :set_transport_mode, only: [:show, :edit, :update, :active, :desactive]

  def index
    @transport_modes = TransportMode.all
  end

  def show
    if(params[:q]).blank?
      @vehicles = Vehicle.weight_between(@transport_mode.min_weight, @transport_mode.max_weight)
    else
      @vehicles = Vehicle.where('plate like ?', "%#{params[:q]}%").weight_between(@transport_mode.min_weight, @transport_mode.max_weight)
    end
    @prices = Price.where('transport_mode_id = ?', params[:id])
  end

  def new
    @transport_mode = TransportMode.new
  end

  def create
    @transport_mode = TransportMode.new(transport_mode_params)
    if @transport_mode.save
      flash[:notice] = 'Modelo de produto cadastrado com sucesso.'
      redirect_to @transport_mode
    else
      @transport_modes = TransportMode.all
      flash.now[:alert] = "Modalidade de Transporte não cadastrado."
      render 'new'
    end
  end

  def edit
  end

  def update

    if @transport_mode.update(transport_mode_params)
      flash[:notice] = 'Modelo de produto atualizado com sucesso'
      redirect_to @transport_mode
    else
      flash.now[:alert] = "Não foi possível atualizar o modelo de produto."
      render 'edit'
    end
  end

  def active
    @transport_mode.enable!
    redirect_to @transport_mode
  end

  def desactive
    @transport_mode.disable!
    redirect_to @transport_mode
  end

  def set_transport_mode
    @transport_mode = TransportMode.find(params[:id])
  end

  def transport_mode_params
    params.require(:transport_mode).permit(:name, :min_range, :max_range, :min_weight, :max_weight, :tax)
  end

end