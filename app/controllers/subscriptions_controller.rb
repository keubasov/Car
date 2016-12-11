class SubscriptionsController < ApplicationController
  require 'tel_bot'
  require 'parser'
  before_action :set_makes, only: [:new, :edit]
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  #before_action :run_telbot, only: :index
  #before_action :run_parser, only: :index
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    unless user_signed_in?
      redirect_to '/subscriptions/for_unsigned_users'
    end
    @subscriptions = Subscription.where(user_id: current_user.id) if current_user
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

 # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

 # GET /subscriptions/1/edit
  def edit
    @current_model_id = @subscription.model_id
    @current_make_id = Make.find_by_model_id @current_model_id
    @models = Model.find_by_make_id @current_make_id
  end

 # POST /subscriptions
 # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: (I18n.t :subscription_created) }
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
        format.html { redirect_to @subscription, notice: (I18n.t :subscription_updated) }
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
      format.html { redirect_to subscriptions_url, notice: (I18n.t :subscription_deleted) }
      format.json { head :no_content }
    end
  end

  def select_model
    make_id=params[:make]
    @models = Model.find_by_make_id make_id
    render partial: 'select_model', object: @models
  end


  private
  def run_telbot
    @telbot ||=Tel_bot.run
  end

  def run_parser
    @parser ||=Par::Parser.parse_cars
  end

  def set_makes
    @makes = Make.all
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params[:subscription][:model_id]=params[:model]
    params[:subscription][:user_id] = current_user.id
    params.require(:subscription).permit(:max_price, :min_year, :model_id, :user_id)
  end
end
