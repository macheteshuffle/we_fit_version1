require 'spec_helper'

describe Favorite do
  before { FactoryGirl.create(:favorite) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:favorited) }
  it { should validate_uniqueness_of(:favorited_id).scoped_to(:user_id) }

  it { should have_valid(:user_id) }
  it { should have_valid(:favorited_id) }

  it { should belong_to(:user) }
  it { should belong_to(:favorited) }
end
