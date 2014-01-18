json.array!(@desk_cases) do |desk_case|
  json.extract! desk_case, :id
  json.url desk_case_url(desk_case, format: :json)
end
