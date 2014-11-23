class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_line_item

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    session[:counter] = 0

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Cart updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  # Removes only one item from cart. Changing quantity to 0 causes the item
  # to be deleted.
  def destroy
    if params[:line_item][:quantity].to_i < 0
      redirect_to cart_url(@line_item.cart.id),
                  notice: "A quantity can't be negative."
    else
      @line_item = LineItem.find(params[:id])
      respond_to do |format|
        if @line_item.update_attribute(:quantity, params[:line_item][:quantity])
          notice = 'Product updated.'
          if @line_item.quantity == 0
            @line_item.destroy
            notice = 'Product removed. You may add it again at any time.'
          end
          format.html { redirect_to cart_url(@line_item.cart.id),
                                    notice: notice }
          format.json { head :no_content }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end

    # Shows error message if user attempts to access invalid line item
    def invalid_line_item
      logger.error "Attempt to access invalid line item #{params[:id]}"
      redirect_to store_url, notice: 'Invalid line item'
    end
end
