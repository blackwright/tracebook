require 'rails_helper'

RSpec.describe Profile, :type => :model do
  
  let (:profile) { build(:profile) }

  it "is valid with default attributes" do
    expect(profile).to be_valid
  end

  it "is valid with filled out information" do
    profile = build(:profile, :filled_out)
    expect(profile).to be_valid
  end

  it "responds to user association" do
    expect(profile).to respond_to(:user)
  end
end
