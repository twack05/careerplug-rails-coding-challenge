require 'spec_helper'
require 'rails_helper'

describe "User Model" do
  it "should require a first name" do
    expect(User.create(last_name: "Wacker", email: "todd@email.com", password: "12345678")).to_not be_valid
    expect(User.create(first_name: "Todd", last_name: "Wacker", email: "todd@email.com", password: "12345678")).to be_valid
  end
  it "should require a last name" do
    expect(User.create(first_name: "Todd", email: "todd@email.com", password: "12345678")).to_not be_valid
    expect(User.create(first_name: "Todd", last_name: "Wacker", email: "todd@email.com", password: "12345678")).to be_valid
  end
  it "should require an email address" do
    expect(User.create(first_name: "Todd", last_name: "Wacker", password: "12345678")).to_not be_valid
    expect(User.create(first_name: "Todd", last_name: "Wacker", email: "todd@email.com", password: "12345678")).to be_valid
  end
  it "should require a password" do
    expect(User.create(first_name: "Todd", last_name: "Wacker", email: "todd@email.com")).to_not be_valid
    expect(User.create(first_name: "Todd", last_name: "Wacker", email: "todd@email.com", password: "12345678")).to be_valid
  end
end
