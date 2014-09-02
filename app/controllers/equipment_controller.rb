#require 'linear'

class EquipmentController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique, :with => :not_unique
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /equipment
  # GET /equipment.json
  def index
    
    @filter = (params[:filter]) ? params[:filter] : (session[:filter]) ? session[:filter] : "true"

    @search = (@filter == 'true') ? Equipment.filter_plant(current_user.plant_id).search(params[:q]) : Equipment.search(params[:q])
    @search.sorts = 'num_id asc' if @search.sorts.empty?
    @equipment = @search.result.includes(:interventions)
    
    session[:filter] = @filter
    
    respond_to do |format|
      format.html
      format.csv { send_data @equipment.to_csv }
      # format.xls # { send_data @equipment.to_csv(col_sep: "\t") }
      format.xlsx
    end
  end
  
  def import
    Equipment.import(current_user.plant_id, params[:file])
    redirect_to equipment_index_path, notice: "Equipamentos importados."
  end



  # GET /equipment/1
  # GET /equipment/1.json
  def show
    
    @filter = (params[:filter]) ? params[:filter] : (session[:filter]) ? session[:filter] : true
    
    @search = (@filter == 'true') ? @equipment.interventions.without_hour_registers.search(params[:q]) : @equipment.interventions.search(params[:q])
    @search.sorts = 'day desc' if @search.sorts.empty?
    @interventions = @search.result
    
    @maintasks = @equipment.maintasks
    
    session[:filter] = @filter
    
    # linear regression of equipment hours estimate
    # @days = []
    # @hours = []
    # @equipment.interventions.each do |interv|
    #   if interv.eq_hours > 0
    #     @days << (Date.today - interv.day).to_i.round(0)
    #     @hours << interv.eq_hours
    #   end
    # end
    # if @days.sort.first == 0 
    #   # If registered today it prints today's equipment hours
    #   @intercept = @hours.sort.last
    # else 
    #   # Else calculates linear regression
    #   @linear = SimpleLinearRegression.new(@days, @hours) if @days.length > 0 
    #   @intercept = @linear.y_intercept if @linear
    # end
    # -------
    
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
  end

  # GET /equipment/1/edit
  def edit
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)
    @equipment.plant_id = current_user.plant.id

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: 'O Equipamento foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment/1
  # PATCH/PUT /equipment/1.json
  def update
    @equipment.plant_id = current_user.plant.id
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html { redirect_to @equipment, notice: 'O Equipamento foi editado com sucesso.' }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment.destroy
    respond_to do |format|
      format.html { redirect_to equipment_index_url, notice: 'O Equipamento foi apagado.' }
      format.json { head :no_content }
    end
  end
  
  private

    def not_unique
      redirect_to edit_equipment_path(params[:id]), notice: 'Já existe um equipamento com esse número.'
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
      @equipment = Equipment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params
      params.require(:equipment).permit(:id, :num_id, :name, :manufacturer, :model, :serial, :assigned_to, :location, :function, :manuf_date, :buy_date, :obs, :maintenance_period, :maintenance_contact)
    end
end
