class IssueHistory < ActiveRecord::Base
	belongs_to :member
	has_many :books, dependent: :destroy
	validates :issue_date, presence: true
	validates :return_date, presence: true
end
