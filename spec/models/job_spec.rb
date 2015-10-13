require 'spec_helper'
require 'rails_helper'

describe "Job Model" do
  before(:each) do
    @user = user = User.create(first_name: "Todd", last_name: "Wacker", email: "todd@email.com", password: "12345678")
  end
  it "should require a User Id" do
    expect(Job.create(name: "Test Job", description: "This is a good job.", status: 1, employment_type: 1)).to_not be_valid
    expect(Job.create(user_id: @user.id, name: "Test Job", description: "This is a good job.", status: 1, employment_type: 1)).to be_valid
  end
  it "should require a name" do
    expect(Job.create(user_id: @user.id, description: "This is a good job.", status: 1, employment_type: 1)).to_not be_valid
    expect(Job.create(user_id: @user.id, name: "Test Job", description: "This is a good job.", status: 1, employment_type: 1)).to be_valid
  end
  it "should require a description" do
    expect(Job.create(user_id: @user.id, name: "Test Job", status: 1, employment_type: 1)).to_not be_valid
    expect(Job.create(user_id: @user.id, name: "Test Job", description: "This is a good job.", status: 1, employment_type: 1)).to be_valid
  end
  it "should require a status" do
    expect(Job.create(user_id: @user.id, name: "Test Job", description: "This is a good job.", employment_type: 1)).to_not be_valid
    expect(Job.create(user_id: @user.id, name: "Test Job", description: "This is a good job.", status: 1, employment_type: 1)).to be_valid
  end
  it "should require an employment type" do
    expect(Job.create(user_id: @user.id, name: "Test Job", description: "This is a good job.", status: 1)).to_not be_valid
    expect(Job.create(user_id: @user.id, name: "Test Job", description: "This is a good job.", status: 1, employment_type: 1)).to be_valid
  end
  describe "Search" do
    before(:each) do
      @job = Job.create(user_id: @user.id, name: "Test Job", description: "This is a good job.", status: 1, employment_type: 1)
      @job2 = Job.create(user_id: @user.id, name: "Guinea Pig Job", description: "This is a decent job.", status: 1, employment_type: 1)
      @job3 = Job.create(user_id: @user.id, name: "Clinical Trial Job", description: "This is an awesome job.", status: 1, employment_type: 1)
    end
    after(:each) do
      @job.destroy()
      @job2.destroy()
      @job3.destroy()
    end
    it "should be able to return search results without being case sensitive" do
      expect(Job.search("test", @user.id).count).to equal(1)
    end
    it "should not return search results for jobs that do not exist" do
      expect(Job.search("boring", @user.id).count).to equal(0)
    end
    it "should not return search results for jobs that were not created by the current user" do
      @job4 = Job.create(user_id: @user.id + 1, name: "Busy Job", description: "This is an okay job.", status: 1, employment_type: 1)
      expect(Job.search("busy", @user.id).count).to equal(0)
    end
    it "should be able to return search results based on Name" do
      expect(Job.search("clinical", @user.id).count).to equal(1)
    end
    it "should be able to return search results based on Description" do
      expect(Job.search("decent", @user.id).count).to equal(1)
    end
    it "should be able to return multiple results" do
      expect(Job.search("job", @user.id).count).to equal(3)
    end
  end
end
