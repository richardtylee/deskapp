class DeskCasesController < ApplicationController
  before_action :set_desk_case, only: [:show, :edit, :update, :destroy]

  # GET /desk_cases
  def index
    @show_labels = params[:labels] == "true"
    
    if @show_labels
     
      @desk_labels = DeskLabel.all
      @label_option_array = [["-- Select Label --","-"]]
      @desk_labels.each do |label|
        name = label.name
        @label_option_array << [name, name]
      end
    end
    
    @desk_cases = DeskCase.all
  end
  
  def append_label
    case_ids = params[:case_id]
    label = params[:label]
    
    fail = false
    error_msg = ""
    
    case_ids.each do |case_id|
      # TODO: Check case exists   

      # Update the case
      response_value = DeskCase.append_label(case_id, label)
      
      # If not successfully, log the error
      if response_value != true
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
