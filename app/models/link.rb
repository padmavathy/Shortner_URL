class Link < ActiveRecord::Base
  validates_presence_of :given_url
  belongs_to :user
end
