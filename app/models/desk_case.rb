require 'active_record/validations'

class DeskCase
  attr_accessor :id, :type, :subject, :status, :labels
  
  def self.all
    desk_cases = []
    response = $access.get(DESK_COM_CONFIG["subdomain"] + "/api/" + DESK_COM_CONFIG["api_version"] + "/cases?filter_id=1974249&sort_field=created_at&sort_direction=asc")
    json = JSON.parse response.body
    hash_array = json["_embedded"]["entries"]
    
    hash_array.each do |hash|
      desk_case = DeskCase.new(hash)
      desk_cases << desk_case
    end
    
    return desk_cases
  end
  
  def self.append_label(case_id, label)
    # Update the case
    data = '{"label_action":"append", "labels":["' + label + '"] }'
    response = $access.put(DESK_COM_CONFIG["subdomain"] + "/api/" + DESK_COM_CONFIG["api_version"] + "/cases/" + case_id, data)
    
    if response.kind_of? Net::HTTPSuccess
      true
    else
      json = JSON.parse response.body
      json["message"] +  " : " + json["errors"].inspect
    end
  end
  
  def initialize(opts = {})
    self.id = opts["id"]
    self.type = opts["type"]
    self.subject = opts["subject"]
    self.status = opts["status"]
    self.labels = opts["labels"]
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
  validates_presence_of :id
end