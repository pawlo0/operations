class InterventionsController < ApplicationController
  before_action :set_intervention, only: [:show, :edit, :update, :destroy]
  before_action :define_user_plant
  load_and_authorize_resource

  # GET /interventions
  # GET /interventions.json
  def index
    
    @filter = (params[:filter]) ? params[:filter] : (session[:filter]) ? session[:filter] : "true"
    
    @search = (@filter == 'true') ? @userplant.interventions.where.not(intervention_type_id: 3).search(params[:q]) : Intervention.search(params[:q])
    @search.sorts = 'day desc' if @search.sorts.empty?
    @interventions = @search.result
    
    @equipments_with_interventions = Equipment.where(id: @interventions.map { |x| x.equipment_id}.uniq).order(:num_id)
    
    session[:filter] = @filter
    
    respond_to do |format|
      format.html
      format.js
      format.xlsx
    end
  end

  def import
    Intervention.import(params[:file])
    redirect_to interventions_path, notice: "Intervenções importadas."
  end

  # GET /interventions/1
  # GET /interventions/1.json
  def show
    @equipment = Equipment.find(params[:equipment_id])
    @interventions = Intervention.where(equipment_id: @equipment.id)
  end

  # GET /interventions/new
  def new
    @equipment = Equipment.find(params[:equipment_id])
    @intervention = Intervention.new
    @interv_day = Date.today
    # When intervention are submited through maintasks the following params are inserted automatically
    if params[:maintask_id]
      @maintask = Maintask.where(id: params[:maintask_id]).first
      @descrip = @maintask.task
      @parts = @maintask.parts
      @intervention_type = 2
    end
    # ----------------------
  end
  
  def hour_register
    @intervention = Intervention.new
    @intervention.attributes = {equipment_id: params[:equipment_id], eq_hours: params[:hours], description: "Registo de horas", day: Date.today, intervention_type_id: InterventionType.where("name LIKE ?", "%regist%ho%").first.id}
    @intervention.save!
    redirect_to equipment_path(params[:equipment_id]), notice: "Horas registadas."
  end
    

  # GET /interventions/1/edit
  def edit
    @equipment = Equipment.find(params[:equipment_id])
  end

  # POST /interventions
  # POST /interventions.json
  def create
    @equipment = Equipment.find(params[:equipment_id])
    @intervention = @equipment.interventions.new(intervention_params)

    respond_to do |format|
      if @intervention.save
        format.html { redirect_to equipment_path(@equipment), notice: 'A intervenção foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interventions/1
  # PATCH/PUT /interventions/1.json
  def update
    @equipment = Equipment.find(@intervention.equipment_id)
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to equipment_intervention_path(@equipment, @intervention), notice: 'A intervenção foi actualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1
  # DELETE /interventions/1.json
  def destroy
    @intervention.destroy
    respond_to do |format|
      format.html { redirect_to equipment_path(@intervention.equipment_id), notice: 'A intervenção foi apagada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def intervention_params
      params.require(:intervention).permit(:day, :equipment_id, :eq_hours, :description, :changed_parts, :maintainer, :task_num, :estimate_num, :purchase_num, :parts_cost, :labor_cost, :intervention_type_id, :maintask_id)
    end

    def define_user_plant
      @userplant = Plant.where(id: current_user.plant_id).first
    end
    
end
