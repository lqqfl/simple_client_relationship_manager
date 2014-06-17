json.array!(@accounts) do |user|
  json.extract! user, :id, :name, :note
  json.url user_url(user, format: :json)
end
