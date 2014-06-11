json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :name, :note
  json.url opportunity_url(opportunity, format: :json)
end
