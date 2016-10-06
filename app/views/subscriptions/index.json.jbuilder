json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :id, :max_price, :min_year, :broken, :type
  json.url subscription_url(subscription, format: :json)
end
