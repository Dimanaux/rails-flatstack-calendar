class Event < ApplicationRecord
  validates :title, presence: true
  belongs_to :account
  has_many :repeats
  
  enum repeat_type: { once: 'once', daily: 'daily', weekly: 'weekly', monthly: 'monthly', annually: 'annually' }

  attr_accessor :from, :to
end
