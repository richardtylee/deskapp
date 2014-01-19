CONFIG = YAML.load_file("#{Rails.root.to_s}/config/settings.yml")

DESK_COM_CONFIG = CONFIG["desk_com"]

consumer = OAuth::Consumer.new(
  DESK_COM_CONFIG["customer_key"],
  DESK_COM_CONFIG["customer_secret"],
  :site => DESK_COM_CONFIG["subdomain"],
  :scheme => :header
)

access_token = OAuth::AccessToken.from_hash(
  consumer,
  :oauth_token => DESK_COM_CONFIG["access_token"],
  :oauth_token_secret => DESK_COM_CONFIG["access_token_secret"]
)

$access = access_token