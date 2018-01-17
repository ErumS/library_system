class Member < ActiveRecord::Base
	has_many :books, dependent: :destroy
	belongs_to :library
  belongs_to :category
	has_many :issue_histories, dependent: :destroy
	enum gender: [ :male, :female]
	validates :name, presence: true
	validates :phone_no, presence: true, length: {maximum: 15}
end
