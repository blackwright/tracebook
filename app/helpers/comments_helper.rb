module CommentsHelper

  def render_delete_link(comment)
    if current_user == comment.author
      if comment.commentable.class == Post
        path = user_post_comment_path(comment.author.id,
                                      comment.commentable.id,
                                      comment.id)
      else
        path = user_photo_comment_path(comment.author.id,
                                       comment.commentable.id,
                                       comment.id)
      end
      content_tag(:span, class: "inline pull-right") do
        link_to("Delete", path, :method => :delete, :remote => true)
      end
    end
  end
end
