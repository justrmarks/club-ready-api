class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :event_id, :created_at, :id, :body


  attribute :user do |comment|
    comment.user
  end

end
