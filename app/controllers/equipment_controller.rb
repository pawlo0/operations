require 'linear'

class EquipmentController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique, :with => :not_unique
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  before_action :define_user_plant
  load_and_authorize_resource

  # GET /equipment
  # GET /equipment.json
  def index

    @filter = (params[:filter]) ? params[:filter] : (session[:filter]) ? session[:filter] : "true"

    @search = (@filter == 'true') ? @userplant.equipment.search(params[:q]) : Equipment.search(params[:q])
    @search.sorts = 'num_id asc' if @search.sorts.empty?
    @equipment = @search.result.includes(:interventions)
    
    session[:filter] = @filter
    
    respond_to do |format|
      format.html
      format.js
      format.xlsx
    end
  end
  
  def import
    Equipment.import(@userplant.id, params[:file])
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
    @interventions_that_are_maintasks = @interventions.where.not(maintask_id: nil)
    
    session[:filter] = @filter
    
    # linear regression of equipment hours estimate
    @days = []
    @hours = []
    @equipment.interventions.each do |interv|
      unless interv.eq_hours == 0 || interv.eq_hours.nil?
        @days << (Date.today - interv.day).to_i.round(0)
        @hours << interv.eq_hours
      end
    end
    if @hours.count == 1
      # when there is only one record, assume that only record. If permited to follow would give NaN error in the linear regression
      @intercept = @hours.first
    else
      if @days.sort.first == 0 
        # If registered today it prints today's equipment hours
        @intercept = @hours.sort.last
      else 
        # Else calculates linear regression
        @linear = SimpleLinearRegression.new(@days, @hours) if @days.length > 0 
        @intercept = @linear.y_intercept if @linear
      end
    end
    # -------
    @delayed_maintasks = []
    # @lag = @interventions.where(maintask_id: 145).sort_by(&:day).last
    @maintasks.each do |maint|
      interv_maint = @interventions.where(maintask_id: maint.id)
      if interv_maint.count > 0
        lag = interv_maint.sort_by(&:day).last.eq_hours + maint.period
        if (lag - @intercept) < 0
          @delayed_maintasks << maint.id
        end
      else
        @delayed_maintasks << maint.id
      end
     end
    
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
    @equipment.plant_id = @userplant.id

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
    @equipment.plant_id = @userplant.id
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
    
    def define_user_plant
      @userplant = Plant.where(id: current_user.plant_id).first
    end
end
