class OrdersController < ApplicationController

  before_action :set_order, only: [:edit, :update, :show_pending, :change_to_in_delivery, :change_to_delivered]

  def index
    if(params[:q]).present?
      @orders = Order.where('code = ? OR sender_name like ? OR recipient_name like ?', params[:q], "%#{params[:q]}%", "%#{params[:q]}%")
    else
      @orders = Order.all
    end
  end

  def show
    @order = Order.includes(:transport_mode, :vehicle).find(params[:id])
  end

  def pending
    @orders = Order.pendent
  end

  def show_pending
    
    if !@order.pendent?
      @orders = Order.pendent
      flash[:alert] = "Não é possível gerar orçamento para esta ordem de entrega. Verifique se a mesma já saiu para entrega ou já foi entregue."
      redirect_to orders_pending_path
    end

    @transport_modes = TransportMode.weight_and_range_between(@order.product_weight, @order.distance).enable

  end

  def change_to_in_delivery #######################################################################################################
    
    if !@order.pendent?
      flash[:alert] = "Não é possível iniciar esta ordem de entrega. Verifique se a mesma já saiu para entrega ou já foi entregue."
      redirect_to orders_pending_path
      return
    end

    transport_mode = TransportMode.find(params[:tm])
    price = Price.find(params[:p])
    vehicle = Vehicle.limit_weight(@order.product_weight).enable.first
    #puts " "
    #puts "modalidade de transporte: #{transport_mode.name}"
    #puts "taxa: #{transport_mode.tax}"
    #puts "preço por km: #{price.km_price}"
    #puts  "veículo indisponível? #{vehicle.nil?}"
    #puts " "

    if vehicle.nil?
      flash[:alert] = "Não é possível iniciar esta ordem de entrega. Nenhum veículo desta modalidade está disponível."
      redirect_to order_pending_path(@order)
      return
    end
    
    deadline = Deadline.find(params[:d])

    prazo = deadline.hours

    @order.transport_mode_id = transport_mode.id
    @order.vehicle_id = vehicle.id
    @order.start = DateTime.now()
    @order.deadline = DateTime.now() + prazo.hours
    @order.tax = transport_mode.tax
    @order.km_price = price.km_price
    @order.price = transport_mode.tax + (@order.distance * price.km_price)

    sucess = @order.save

    if sucess
      @order.in_delivery!
      vehicle.in_delivery!
      flash[:notice] = "Ordem de Entrega iniciada com sucesso."
    else
      flash[:alert] = "Não foi possível iniciar a ordem de entrega."
    end

    redirect_to @order

  end #######################################################################################################

  def change_to_delivered #######################################################################################################
    
    if !@order.in_delivery?
      flash[:alert] = "Não é possível finalizar esta ordem de entrega. Verifique se a mesma está pendente ou já foi entregue."
      redirect_to orders_path
      return
    end
    
    if @order.deadline < DateTime.now()
      if(params[:order][:delay_reason]).empty?
        flash[:alert] = "Informe o motivo do atraso na entrega, para finalizar a mesma."
        redirect_to @order
        return
      end
    end

    vehicle = Vehicle.find(@order.vehicle_id)

    @order.delivered = DateTime.now()
    @order.delay_reason = params[:order][:delay_reason]

    sucess = @order.save

    if sucess
      @order.delivered!
      vehicle.enable!
      flash[:notice] = "Ordem de Entrega finalizada com sucesso."
    else
      flash[:alert] = "Não foi possível finalizar a ordem de entrega."
    end

    redirect_to @order

  end #######################################################################################################

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

  def edit
    if !@order.pendent?
      flash[:alert] = "Não é possível editar esta ordem de entrega. Verifique se a mesma já saiu para entrega ou já foi entregue."
      redirect_to order_path
    end
  end

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
                                  :transport_mode_id,
                                  :vehicle_id)
  end

end