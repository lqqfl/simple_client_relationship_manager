json.array!(@companies) do |company|
  json.extract! company, :id, :name, :note
  json.url company_url(company, format: :json)
end
