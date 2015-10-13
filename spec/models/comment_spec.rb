require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @job = Job.create(user_id: @user.id, name: "Test Job", description: "This is a good job.", status: 1, employment_type: 1)
  end
  it "should require a job_id" do
    expect(Comment.create(author: "Me", text: "This site rocks!")).to_not be_valid
    expect(Comment.create(author: "Me", text: "This site rocks!")).to_not be_valid
  end
  it "should require an author" do

  end
  it "should require text" do

  end
end
