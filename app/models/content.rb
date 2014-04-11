class Content < ActiveRecord::Base
  belongs_to :page
  validates :title, presence: true
  validates :priority, presence: true
end
