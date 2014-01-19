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
    @desk_cases = json["_embedded"]["entries"]
  end
  
  def append_label
    case_ids = params[:case_id]
    label = params[:label]
    
    fail = false
    error_msg = ""
    
    case_ids.each do |case_id|
      # TODO: Check case exists   

      # TODO: Move code to model
      # Update the case
      data = '{"label_action":"append", "labels":["' + label + '"] }'
      response = $access.put("https://richardtylee.desk.com/api/v2/cases/" + case_id, data)
      
      # If not successfully, log the error
      if ! response.kind_of? Net::HTTPSuccess
         json = JSON.parse response.body
         error_msg += json["message"] +  " : " + json["errors"].inspect
         fail = true
      end
    end
    if fail
      flash[:error] = error_msg
    else
      flash[:notice] = "All labels appended successfully."
    end
    redirect_to :action => :index
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def desk_case_params
      params[:desk_case]
    end
end
