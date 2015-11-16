class CommentsController < InheritedResources::Base

  private

    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :body, :ancestry)
    end
end

