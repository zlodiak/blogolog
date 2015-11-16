json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :post_id, :body, :ancestry
  json.url comment_url(comment, format: :json)
end
