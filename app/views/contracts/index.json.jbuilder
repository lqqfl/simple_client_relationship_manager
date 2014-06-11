json.array!(@contracts) do |contract|
  json.extract! contract, :id, :name, :amount, :note, :time
  json.url contract_url(contract, format: :json)
end
