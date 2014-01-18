consumer = OAuth::Consumer.new(
  "UKKln9ZW7XCG2qCvtGHw",
  "LVOIrAHspvdZ7dY1XtoO0oHX6o41fhnNVqyhZ00O",
  :site => "https://richardtylee.desk.com",
  :scheme => :header
)

access_token = OAuth::AccessToken.from_hash(
  consumer,
  :oauth_token => "UMEVwrygiEVUBRquQpbA",
  :oauth_token_secret => "gtwKICYAMau4ZTVFkQ6huMZtlSbpG0czs8sKrLlq"
)

$access = access_token