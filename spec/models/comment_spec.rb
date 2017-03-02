require 'rails_helper'

RSpec.describe Comment, :type => :model do

  let (:post_comment) { build(:post_comment) }
  let (:photo_comment) { build(:photo_comment) }

  it "post type is valid with default attributes" do
    expect(post_comment).to be_valid
  end

  it "post type responds to author association" do
    expect(post_comment).to respond_to(:author)
  end

  it "photo type is valid with default attributes" do
    expect(photo_comment).to be_valid
  end

  it "photo type responds to author association" do
    expect(photo_comment).to respond_to(:author)
  end

  it "all types respond to parent association" do
    expect(post_comment).to respond_to(:commentable)
    expect(photo_comment).to respond_to(:commentable)
  end
end
