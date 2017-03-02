require 'rails_helper'

RSpec.describe Post, :type => :model do
  
  let (:post) { build(:post) }

  it "is valid with default attributes" do
    expect(post).to be_valid
  end

  it "is invalid with no body text" do
    post = build(:post, :body => nil)
    expect(post).not_to be_valid
  end
end
