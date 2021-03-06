module CommentsHelper
  def nested_comments(comments)
    comments.map do |message, sub_comments|
      render(message) + content_tag(:div, nested_comments(sub_comments), :class => "nested_comments")
    end.join.html_safe
  end  

  def comment_like(comment_id)
    return CommentLike.where(comment_id: comment_id).count
  end

  def comment_author(comment_id)
    comment = Comment.find(comment_id)
    return User.find(comment.user_id)
  end
end
