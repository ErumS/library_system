class Book < ActiveRecord::Base
	belongs_to :library
	belongs_to :category
	belongs_to :issue_history
	validates :name, presence: true
end
