require 'rails_helper'
require 'spec_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @job = Job.create(user_id: 2, name: "Test Job", description: "This is a good job.", status: 1, employment_type: 1)
  end
  it "should require a job_id" do
    expect(Comment.create(author: "Me", text: "This site rocks!")).to_not be_valid
    expect(Comment.create(job_id: @job.id, author: "Me", text: "This site rocks!")).to be_valid
  end
  it "should require an author" do
    expect(Comment.create(job_id: @job.id, text: "This site rocks!")).to_not be_valid
    expect(Comment.create(job_id: @job.id, author: "Me", text: "This site rocks!")).to be_valid
  end
  it "should require text" do
    expect(Comment.create(job_id: @job.id, author: "Me")).to_not be_valid
    expect(Comment.create(job_id: @job.id, author: "Me", text: "This site rocks!")).to be_valid
  end
end
