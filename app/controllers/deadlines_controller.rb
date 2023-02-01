class DeadlinesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_deadline, only: [:edit, :update, :destroy]

  def index
    @deadlines = Deadline.order(transport_mode_id: :asc, min_range: :asc).all
  end

  def new
    @transport_modes = TransportMode.order(name: :asc).all
    @deadline = Deadline.new
  end

  def create
    @transport_modes = TransportMode.all
    @deadline = Deadline.new(deadline_params)
    if @deadline.save
      flash.now[:notice] = "Prazo cadastrado com sucesso."
      redirect_to deadlines_path
    else
      flash.now[:alert] = "Prazo não cadastrado."
      render 'new'
    end
  end

  def edit
    @transport_modes = TransportMode.all
  end

  def update
    @transport_modes = TransportMode.all
    if @deadline.update(deadline_params)
      flash[:notice] = 'Prazo atualizado com sucesso'
      redirect_to deadlines_path
    else
      flash.now[:alert] = "Não foi possível atualizar o prazo."
      render 'edit'
    end
  end

  def destroy
    @deadline.destroy
    flash[:alert] = "Prazo removido com sucesso."
    redirect_to deadlines_path
  end

  private

  def set_deadline
    @deadline = Deadline.find(params[:id])
  end

  def deadline_params
    params.require(:deadline).permit(:min_range, :max_range, :hours, :transport_mode_id)
  end
  
end