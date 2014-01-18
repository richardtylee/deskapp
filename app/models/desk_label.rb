require 'active_record/validations'

class DeskLabel
  attr_accessor :id, :name, :description, :color
  
  # For the ActiveRecord::Errors object.
  #attr_accessor :errors
  
  def initialize(opts = {})
    self.name = opts["name"]
    self.description = opts["description"]
    self.color = opts["color"]
  end
  
  # Dummy stub to make validtions happy.
  def save
    puts self.color
    data = '{"name":"' + self.name + '","description":"'+ self.description +
      '", "types": ["case", "macro"], "color": "' + self.color + '"}'
    response = $access.post("https://richardtylee.desk.com/api/v2/labels", data)
    
    response_code_int = response.code.to_i
    
    if response.code.to_i >= 200 && response.code.to_i <= 299
      true
    else
      false
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
    key = self.id
    [key] if key
  end
  
  def persisted?
    !(self.id.nil?)
  end
  
  # Dummy stub to make validtions happy.
  def update_attribute
  end
  
  # Mix in that validation goodness!
  include ActiveRecord::Validations
  
  # Use validations.
  validates_presence_of :name
end