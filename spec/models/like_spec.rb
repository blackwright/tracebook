require 'rails_helper'

RSpec.describe Like, :type => :model do

  let (:post_like) { build(:post_like) }
  let (:post_comment_like) { build(:post_comment_like) }
  let (:photo_like) { build(:photo_like) }
  let (:photo_comment_like) { build(:photo_comment_like) }

  it "valid with default attributes" do
    expect(post_like).to be_valid
    expect(post_comment_like).to be_valid
    expect(photo_like).to be_valid
    expect(photo_comment_like).to be_valid
  end

  it "responds to liker association" do
    expect(post_like).to respond_to(:liker)
    expect(post_comment_like).to respond_to(:liker)
    expect(photo_like).to respond_to(:liker)
    expect(photo_comment_like).to respond_to(:liker)
  end

  it "responds to likeable association" do
    expect(post_like).to respond_to(:likeable)
    expect(post_comment_like).to respond_to(:likeable)
    expect(photo_like).to respond_to(:likeable)
    expect(photo_comment_like).to respond_to(:likeable)
  end
end
