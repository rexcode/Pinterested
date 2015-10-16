class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  #added so that only authen. user can see CRUD pages except index n show pages regarding pins
  before_action :authenticate_user!, except: [:index, :show]
  # only correct user can edit, update or destroy his pins
  before_action :correct_user, only: [:edit, :update, :destroy]  

  respond_to :html

  def index
    @pins = Pin.all
    respond_with(@pins)
  end

  def show
    respond_with(@pin)
  end

  def new
    # @pin = Pin.new
    @pin = current_user.pins.build
    respond_with(@pin)
  end

  def edit
  end

  def create
    # @pin = Pin.new(pin_params)
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render action: 'new'
    # end   
    # respond_with(@pin)
  end
end

  def update
    # @pin.update(pin_params)
    if @pin.update(pin_params)
    redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    # end    
    # respond_with(@pin)
    end
end

  def destroy
    @pin.destroy
    respond_with(@pin)
  end

  private
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def pin_params
      params.require(:pin).permit(:description, :image)
    end
    
    def correct_user
      @pin  = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: 'Not authorized to edit this pin' if @pin.nil?
    end
        
end
