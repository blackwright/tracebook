require 'rails_helper'

RSpec.describe User, :type => :model do
  
  let (:user) { build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "is invalid with no first name" do
    user = build(:user, :first_name => nil)
    expect(user).not_to be_valid
  end

  it "is invalid with no last name" do
    user = build(:user, :last_name => nil)
    expect(user).not_to be_valid
  end

  it "is invalid with no password" do
    user = build(:user, :password => nil)
    expect(user).not_to be_valid
  end

  it "is invalid with password under 8 character length" do
    password = rand(36**7).to_s(36)
    user = build(:user, :password => password)
    expect(user).not_to be_valid
  end

  it "is valid with password of 8 character length" do
    password = rand(36**8).to_s(36)
    user = build(:user, :password => password)
    expect(user).to be_valid
  end

  it "is valid with password of 24 character length" do
    password = rand(36**24).to_s(36)
    user = build(:user, :password => password)
    expect(user).to be_valid
  end

  it "is invalid with password over 24 character length" do
    password = rand(36**25).to_s(36)
    user = build(:user, :password => password)
    expect(user).not_to be_valid
  end
end
