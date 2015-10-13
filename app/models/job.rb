# == Schema Information
#
# Table name: jobs
#
#  id              :integer          not null, primary key
#  name            :string
#  status          :integer
#  description     :text
#  employment_type :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Job < ActiveRecord::Base
  enum status: [:active, :inactive]
  enum employment_type: [:full_time, :part_time]

  validates_presence_of :name, :description, :status, :employment_type, :user_id
  belongs_to :user
  has_many :comments

  def self.search(query, user_id)
    name_query = Job.where("lower(name) like ?", "%#{query.downcase}%")
    description_query = Job.where("lower(description) like ?", "%#{query.downcase}%")
    Job.from("(#{name_query.to_sql} UNION #{description_query.to_sql}) AS jobs").where(user_id: user_id)
  end
end
