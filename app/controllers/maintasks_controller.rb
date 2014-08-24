class MaintasksController < ApplicationController
  before_action :set_maintask, only: [:show, :edit, :update, :destroy]

  # GET /maintasks
  # GET /maintasks.json
  def index
    
    @equipment = Equipment.where(plant_id: current_user.plant_id)
    @equipment_ids = @equipment.pluck(:id)
    @search = Maintask.where(equipment_id: @equipment_ids).search(params[:q])
    @search.sorts = 'equipment_id asc' if @search.sorts.empty?
    @maintasks = @search.result.includes(:equipment)
    
    @equip_with_maintasks = @equipment.where(id: (@maintasks.map {|x| x.equipment_id}.uniq))
    
    respond_to do |format|
      format.html
      format.csv { send_data @maintasks.to_csv }
      format.xls 
      format.xlsx
    end
    
  end

  # GET /maintasks/1
  # GET /maintasks/1.json
  def show
  end

  # GET /maintasks/new
  def new
    @equipment = Equipment.find(params[:equipment_id])
    @maintask = Maintask.new
  end

  # GET /maintasks/1/edit
  def edit
    @equipment = Equipment.find(params[:equipment_id])
  end

  # POST /maintasks
  # POST /maintasks.json
  def create
    @maintask = Maintask.new(maintask_params)

    respond_to do |format|
      if @maintask.save
        format.html { redirect_to equipment_maintask_path(@maintask.equipment_id,@maintask), notice: 'A tarefa de manutenção foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @maintask }
      else
        format.html { render :new }
        format.json { render json: @maintask.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintasks/1
  # PATCH/PUT /maintasks/1.json
  def update
    respond_to do |format|
      if @maintask.update(maintask_params)
        format.html { redirect_to equipment_maintask_path(@maintask.equipment_id,@maintask), notice: 'A tarefa foi actualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @maintask }
      else
        format.html { render :edit }
        format.json { render json: @maintask.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintasks/1
  # DELETE /maintasks/1.json
  def destroy
    @maintask.destroy
    respond_to do |format|
      format.html { redirect_to equipment_path(@maintask.equipment_id), notice: 'A tarefa foi apagada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintask
      @maintask = Maintask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintask_params
      params.require(:maintask).permit(:equipment_id, :task, :period, :unit, :parts, :obs)
    end
end
