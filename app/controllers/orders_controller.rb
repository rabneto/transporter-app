class OrdersController < ApplicationController

  before_action :set_order, only: [:show, :edit, :update]

  def index
    if(params[:q]).present?
      @orders = Order.where('code = ? OR sender_name like ? OR recipient_name like ?', params[:q], "%#{params[:q]}%", "%#{params[:q]}%")
    else
      @orders = Order.all
    end
  end

  def show; end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = "Ordem de Entrega cadastrada com sucesso."
      redirect_to order_path(@order.id)
    else
      flash.now[:alert] = "Ordem de Entrega não cadastrada."
      render 'new'
    end
  end

  def edit; end

  def update
    if @order.update(order_params)
      flash[:notice] = "Ordem de Entrega atualizada com sucesso."
      redirect_to @order
    else
      flash.now[:alert] = "Não foi possível atualizar a ordem de serviço."
      render 'edit'
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:start,
                                  :deadline,
                                  :delivered,
                                  :delay_reason,
                                  :distance,
                                  :product_id,
                                  :product_width,
                                  :product_height,
                                  :product_depth,
                                  :product_weight,
                                  :origin_address,
                                  :origin_city,
                                  :origin_uf,
                                  :destiny_address,
                                  :destiny_city,
                                  :destiny_uf,
                                  :sender_name,
                                  :sender_document,
                                  :sender_phone,
                                  :sender_email,
                                  :recipient_name,
                                  :recipient_document,
                                  :recipient_email,
                                  :recipient_phone,
                                  :transport_mode_id)
  end

end