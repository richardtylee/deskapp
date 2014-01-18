class DeskLabelsController < ApplicationController
  def index
    response = $access.get("https://richardtylee.desk.com/api/v2/labels")
    
    json = JSON.parse response.body
    
    @desk_cases = json["_embedded"]["entries"]    
  end
end
