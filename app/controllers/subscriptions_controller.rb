class SubscriptionsController < ApplicationController
  require 'tel_bot'
  require 'parser'
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  #before_action :run_telbot, only: :index
  #before_action :run_parser, only: :index
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
    @brands = Brand.all
  end

  # GET /subscriptions/1/edit
  def edit
    @brands = Brand.all.to_a
    @current_type_id = @subscription.type_id
    @current_brand_id = Brand.find(Type.find(@current_type_id).brand_id).id
    @types = Type.where(brand_id: @current_brand_id).to_a
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def select_type
    brand_id=params[:brand]
    @types = (Type.where(brand_id: brand_id)).to_a
    render partial: 'select_type', object: @types
  end

  private
    def run_telbot
      @telbot ||=Tel_bot.run
    end
    def run_parser
      @parser ||=Par::Parser.parse_cars
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params[:subscription][:type_id]=params[:type]
      params[:subscription][:user_id] = current_user.id
      params.require(:subscription).permit(:max_price, :min_year, :broken, :type_id, :user_id)
    end
end
