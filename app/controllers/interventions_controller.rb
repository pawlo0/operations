class InterventionsController < ApplicationController
  before_action :set_intervention, only: [:show, :edit, :update, :destroy]

  # GET /interventions
  # GET /interventions.json
  def index
    @interventions = Intervention.all
  end

  # GET /interventions/1
  # GET /interventions/1.json
  def show
  end

  # GET /interventions/new
  def new
    @equipment = Equipment.find(params[:equipment_id])
    @intervention = Intervention.new
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
        format.html { redirect_to equipment_intervention_path(@equipment, @intervention), notice: 'A intervention foi actualizada com sucesso.' }
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
      params.require(:intervention).permit(:day, :equipment_id, :eq_hours, :repair, :preventive, :description, :changed_parts, :maintainer, :task_num, :estimate_num, :purchase_num, :parts_cost, :labor_cost)
    end
end
