class DeskCasesController < ApplicationController
  before_action :set_desk_case, only: [:show, :edit, :update, :destroy]

  # GET /desk_cases
  # GET /desk_cases.json
  def index
    # @desk_cases = DeskCase.all    
    response = $access.get("https://richardtylee.desk.com/api/v2/cases?filter_id=1850994")
    
    json = JSON.parse response.body
    
    puts response.body
    
    @desk_cases = json["_embedded"]["entries"]
  end

  # GET /desk_cases/1
  # GET /desk_cases/1.json
  def show
  end

  # GET /desk_cases/new
  def new
    @desk_case = DeskCase.new
  end

  # GET /desk_cases/1/edit
  def edit
  end

  # POST /desk_cases
  # POST /desk_cases.json
  def create
    @desk_case = DeskCase.new(desk_case_params)

    respond_to do |format|
      if @desk_case.save
        format.html { redirect_to @desk_case, notice: 'Desk case was successfully created.' }
        format.json { render action: 'show', status: :created, location: @desk_case }
      else
        format.html { render action: 'new' }
        format.json { render json: @desk_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /desk_cases/1
  # PATCH/PUT /desk_cases/1.json
  def update
    respond_to do |format|
      if @desk_case.update(desk_case_params)
        format.html { redirect_to @desk_case, notice: 'Desk case was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @desk_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /desk_cases/1
  # DELETE /desk_cases/1.json
  def destroy
    @desk_case.destroy
    respond_to do |format|
      format.html { redirect_to desk_cases_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_desk_case
      @desk_case = DeskCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def desk_case_params
      params[:desk_case]
    end
end
