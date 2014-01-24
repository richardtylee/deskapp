require 'active_record/validations'

class DeskLabel
  attr_accessor :name, :description, :color, :enabled
  
  def self.all
    desk_labels = []
     response = $access.get(DESK_COM_CONFIG["subdomain"] + "/api/" + DESK_COM_CONFIG["api_version"] + "/labels")
    
    json = JSON.parse response.body
    
    hash_array = json["_embedded"]["entries"]
    
    hash_array.each do |hash|
      desk_label = DeskLabel.new(hash)
      desk_labels << desk_label
    end
    
    return desk_labels
  end
  
  def initialize(opts = {})
    self.name = opts["name"]
    self.description = opts["description"]
    self.color = opts["color"]
    self.enabled = opts["enabled"]
  end
  
  def save
    data = '{"name":"' + self.name + '","description":"'+ self.description +
      '", "types": ["case", "macro"], "color": "' + self.color + '"}'
    response = $access.post(DESK_COM_CONFIG["subdomain"] + "/api/" + DESK_COM_CONFIG["api_version"] + "/labels", data)
    
    if response.kind_of? Net::HTTPSuccess
      true
    else
      json = JSON.parse response.body
      json["message"] +  " : " + json["errors"].inspect
    end
  end
  
  # Dummy stub to make validtions happy.
  def save!
  end
  
  # Dummy stub to make validtions happy.
  def new_record?
  
  false
  
  end
  
  def to_key
    key = self.name
    [key] if key
  end
  
  def persisted?
    !(self.name.nil?)
  end
  
  # Dummy stub to make validtions happy.
  def update_attribute
  end
  
  # Mix in that validation goodness!
  include ActiveRecord::Validations
  
  # Use validations.
  validates_presence_of :name
end