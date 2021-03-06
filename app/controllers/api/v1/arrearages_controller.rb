class Api::V1::ArrearagesController < Api::V1::BaseController

  before_action :authenticate_user!
  before_action :set_arrearage, only: [:show, :update, :destroy]

  def index
    params[:page] ||= 0
    if params[:action] == "pending"
      @arrearages = @current_resource.arrearages.pending.page(params[:page])
    else
      @arrearages = @current_resource.arrearages.paid.page(params[:page])
    end

    render :index

  end

  alias_method :pending, :index
  alias_method :paid, :index

  def show
  end

  def create
    @arrearage = @current_resource.arrearages.create!(arrearage_params)
  end

  def update
    @arrearage.update!(arrearage_params)
  end

  def destroy
    @arrearage.destroy!
  end

  private

  def set_arrearage
    @arrearage = @current_resource.arrearages.find(params[:id])
  end

  def arrearage_params
    params.permit(:receiver_id, :payment_type, :category, :title, :description, :total_value, :installment_number, :pay_at)
  end

  def arrearage_update_params
    params.permit(:total_value)
  end

end
