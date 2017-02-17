module CommentsHelper

  def comment_feedback(likeable)
    num_likers = likeable.likers.size
    if num_likers > 0
      result = ""
      if likeable.likers.include?(current_user)
        result << "You "
        num_others = num_likers - 1
        result << "and #{pluralize(num_others, 'person')} " if num_others > 0
        result << "like this."
      else
        result << "#{pluralize(num_likers, 'person')} "
        result << "#{num_likers > 1 ? 'like' : 'likes'} this."
      end
    else
      nil
    end
  end

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
        link_to("Delete", path, :method => :delete)
      end
    end
  end
end
