module PostsHelper

  def pubdate(date)
    date.strftime("%Y-%m-%d")
  end

  def posted_on(date)
    "Posted on #{date.strftime('%B %-d, %Y')}"
  end

  def post_feedback(likeable)
    num_likers = likeable.likers.size
    if num_likers > 0
      result = ""
      if num_likers == 1
        if likeable.likers.include?(current_user)
          result << "You like"
        else
          liker = likeable.likers.first
          result << link_to(liker.full_name, user_path(liker)) + " likes"
        end
      else
        array = []
        array << "You" if likeable.likers.include?(current_user)
        i = 0
        until array.size == 2
          liker = likeable.likers[i]
          unless liker == current_user
            array << link_to(liker.full_name, user_path(liker))
          end
          i += 1
        end
        if num_likers == 2
          result << array.join(" and ") + " like"
        else
          result << array.join(", ") +
                    ", and #{pluralize(num_likers - 2, 'other')} like"
        end
      end
      result << " this."
      result.html_safe
    else
      nil
    end
  end

  def render_like_link(likeable)
    if likeable.likers.include? current_user
      link_to "Unlike",
        like_path(likeable.likes.find_by_user_id(current_user.id)),
        :method => :delete
    else
      link_to "Like",
        likes_path(:like => { likeable_type: likeable.class,
                              likeable_id: likeable.id }),
        :method => :post
    end
  end
end
