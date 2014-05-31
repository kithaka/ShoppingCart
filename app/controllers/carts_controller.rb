class CartsController < ApplicationController
  # GET /carts
  # GET /carts.json
  skip_before_filter :authorize, :only=>[:create, :update, :destroy]
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    begin
    @cart = Cart.find(params[:id])
  rescue ActiveRecord::RecordNotFound
   logger.error "Attempt to acess invalid cart #{params[:id]}"
    #uses the cart controller logger to record the recordnotfound error
    redirect_to store_url, :notice=>'Invalid cart'
   # notice: 'Invalid displays in the store_url after redirect'
  else
    respond_to do |format|
      format.html #show.html.erb
      format.json { render :json => @cart }
    end
  end
end

  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, :notice => 'Cart was successfully created.' }
        format.json { render :json => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.json { render :json => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, :notice => 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart =current_cart
    #Cart.find(params[:id])
    @cart.destroy
    session[:cart_id]=nil
    respond_to do |format|
      format.html { redirect_to (store_url), :notice=>'Your cart is currently empty'}
        #carts_url , initisl redirect
      format.json { head :ok }
    end
  end
end