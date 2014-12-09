class CustomersController < ApplicationController

  include CurrentUser
  skip_before_action :authorize, only: [:new, :create]
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.order(:email)   # Returns customers ordered by name

    if !admin_logged_in
      redirect_to admin_url
    else
      redirect_to customers_url
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html {
          redirect_to customer_path(@customer.id),
                      notice: "Your account was successfully created." }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    # Checks that current password is valid.
    current_password = params[:customer].delete('current_password')
    unless @customer.authenticate(current_password)
      @customer.errors.add(:current_password, 'is not valid')
    end
    respond_to do |format|
      # Updates the customer if pertinent.
      if @customer.errors.empty? && @customer.update(customer_params)
        format.html {
          redirect_to customers_url,
                      notice: "Customer #{@customer.firstname} was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
      else
        # Displays errors if customer couldn't be updated.
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    begin
      @customer.destroy
      flash[:notice] = "Customer #{@customer.firstname} deleted"
    rescue StandardError => e
      # Catches exception to show it to customer in a flash.
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:email, :firstname, :lastname, :password,
                                       :password_confirmation)
    end
end
