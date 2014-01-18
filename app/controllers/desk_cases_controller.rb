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
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def desk_case_params
      params[:desk_case]
    end
end
