class DeskCasesController < ApplicationController
  before_action :set_desk_case, only: [:show, :edit, :update, :destroy]

  # GET /desk_cases
  # GET /desk_cases.json
  def index
    @show_labels = params[:labels] == "true"
    
    if @show_labels
      response = $access.get("https://richardtylee.desk.com/api/v2/labels")
      json = JSON.parse response.body
      @desk_labels = json["_embedded"]["entries"]
      @label_option_array = [["-- Select Label --","-"]]
      @desk_labels.each do |label|
        name = label["name"]
        @label_option_array << [name, name]
      end
    end
    
    response = $access.get("https://richardtylee.desk.com/api/v2/cases?filter_id=1850994&sort_field=created_at&sort_direction=asc")
    json = JSON.parse response.body
    puts json
    @desk_cases = json["_embedded"]["entries"]
  end
  
  def append_label
    case_ids = params[:case_id]
    label = params[:label]
    
    case_ids.each do |case_id|
      # Check case exists   

      # Data
      data = '{"label_action":"append", "labels":["' + label + '"] }'
      response = $access.put("https://richardtylee.desk.com/api/v2/cases/" + case_id, data)
    end
    
    redirect_to :action => :index
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def desk_case_params
      params[:desk_case]
    end
end
