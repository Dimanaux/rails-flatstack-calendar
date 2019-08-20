class Event < ApplicationRecord
  validates :title, presence: true
  belongs_to :account
  has_many :repeats, dependent: :delete_all

  enum repeat_type: { once: 'once', daily: 'daily', weekly: 'weekly', monthly: 'monthly', annually: 'annually' }

  attr_accessor :from, :to

  def create_repeats
    if self.once?
      repeat_once!
    else
      repeat!(time_unit(self.repeat_type))
    end
  end

  private

  def time_unit(repeat_type)
    return :years if repeat_type == 'annually'
    self.repeat_type.sub('ly', 's').to_sym
  end

  def repeat!(timeunit)
    timeunit_proc = timeunit.to_proc
    i = 0
    repeat_date = self.from + timeunit_proc.call(i)
    while repeat_date <= self.to
      Repeat.create(event: self, datetime: repeat_date)
      i += 1
      repeat_date = self.from + timeunit_proc.call(i)
    end
  end

  def repeat_once!
    Repeat.create(event: self, datetime: self.from)
  end
end
