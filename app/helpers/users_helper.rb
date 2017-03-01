module UsersHelper

  def render_profile_or_friend_link(user)
    if current_user == user
      link_to "Edit Profile", edit_user_profile_path(current_user),
                              id: "profile-link", class: "right"
    else
      if current_user.friends_with?(user)
        link_to "Unfriend", friending_path(user),
                            :method => :delete,
                            id: "profile-link",
                            class: "btn btn-primary right"
      else
        link_to "+ Friend", friendings_path(:id => user.id),
                            :method => :post,
                            id: "profile-link",
                            class: "btn btn-primary right"
      end
    end
  end

  def render_friend_or_unfriend(user)
    if current_user.all_friends.include?(user)
      link_to "Unfriend", friending_path(user),
                          :method => :delete, class: "btn btn-default right"
    elsif current_user.requested_users.include?(user)
      content_tag(:div, "Request Sent",
                        class: "btn btn-default disabled right")
    else
      link_to "+ Friend", friendings_path(:id => user.id),
                        :method => :post, class: "btn btn-primary right"
    end
  end
end
