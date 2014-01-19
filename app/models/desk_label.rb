require 'active_record/validations'

class DeskLabel
  attr_accessor :name, :description, :color
  
  def initialize(opts = {})
    self.name = opts["name"]
    self.description = opts["description"]
    self.color = opts["color"]
  end
  
  def save
    data = '{"name":"' + self.name + '","description":"'+ self.description +
      '", "types": ["case", "macro"], "color": "' + self.color + '"}'
    response = $access.post("https://richardtylee.desk.com/api/v2/labels", data)
    
    response_code_int = response.code.to_i
    
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