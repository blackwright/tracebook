require 'rails_helper'

RSpec.describe Photo, :type => :model do

  let (:photo) { build(:photo) }

  it "responds to author association" do
    expect(photo).to respond_to(:author)
  end
end
