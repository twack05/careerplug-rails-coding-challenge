class Comment < ActiveRecord::Base
  validates_presence_of :job_id, :author, :text
  belongs_to :job
end
