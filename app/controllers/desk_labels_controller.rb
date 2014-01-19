class DeskLabelsController < ApplicationController
  def index
    @desk_labels = DeskLabel.all   
  end
  
  def new
    @desk_label = DeskLabel.new()
  end
  
  def create
    @desk_label = DeskLabel.new(params["desk_label"])
    respond_to do |format|
      response_value = @desk_label.save
      if response_value == true
        flash[:notice] = "Label created successfully"
        format.html { redirect_to action: 'index' }
      else
        flash[:error] = response_value
        format.html { redirect_to action: 'new' }
      end
    end
  end
end
