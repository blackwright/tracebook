module PostsHelper

  def pubdate(date)
    date.strftime("%Y-%m-%d")
  end

  def posted_on(date)
    "Posted on #{date.strftime('%B %-d, %Y')}"
  end
end
