json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :time, :note
  json.url activity_url(activity, format: :json)
end
