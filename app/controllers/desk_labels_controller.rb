class DeskLabelsController < ApplicationController
  def index
    response = $access.get("https://richardtylee.desk.com/api/v2/labels")
    
    json = JSON.parse response.body
    
    @desk_labels = json["_embedded"]["entries"]    
  end
  
  def new
    @desk_label = DeskLabel.new()
  end
  
  def create
    @desk_label = DeskLabel.new(params["desk_label"])
    respond_to do |format|
      if @desk_label.save
        format.html { redirect_to action: 'index' }
      else
        format.html { redirect_to action: 'new' }
      end
    end
=begin
    respond_to do |format|
      if @desk_label.save
        format.html { redirect_to @desk_label, notice: 'Desk label was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
=end
  end
end
