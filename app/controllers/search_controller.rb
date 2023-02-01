class SearchController < ApplicationController
  layout "devise"

  def show; end
  
  def result
    @order = Order.where(code: params[:code]).first

    if @order.nil?
      flash[:alert] = "Nenhuma ordem de entrega encontrada para este código."
      redirect_to search_path
      return
    end
    if !@order.vehicle_id.nil?
      @vehicle = Vehicle.find(@order.vehicle_id)
    end

    if @order.status == "pendent"
      @active_pendent = "-active"
    elsif @order.status == "in_delivery"
      @active_pendent = "-active"
      @active_in_delivery = "-active"
    elsif @order.status == "delivered"
      @active_pendent = "-active"
      @active_in_delivery = "-active"
      @active_delivered = "-active"
    end

  end

end