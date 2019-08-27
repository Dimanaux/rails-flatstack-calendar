class Event < ApplicationRecord
  validates :title, presence: true
  belongs_to :account
  has_many :repeats, dependent: :delete_all

  enum repeat_type: {
    once: 'once', daily: 'daily',
    weekly: 'weekly', monthly: 'monthly',
    annually: 'annually'
  }

  attr_accessor :from, :to

  def create_repeats
    if once?
      repeat_once!
    else
      repeat!(time_unit(repeat_type))
    end
  end

  def update_repeats
    Repeat.where('event_id = :id', id: id).destroy_all
    create_repeats
  end

  def fetch_from_to!
    self.from = repeats.map(&:datetime).min
    self.to = repeats.map(&:datetime).max unless once?
  end

  private

  def time_unit(repeat_type)
    return :years if repeat_type == 'annually'
    repeat_type.sub('ly', 's').to_sym
  end

  def repeat!(timeunit)
    timeunit_proc = timeunit.to_proc
    i = 0
    repeat_date = from + timeunit_proc.call(i)
    while repeat_date <= to
      Repeat.create(event: self, datetime: repeat_date)
      i += 1
      repeat_date = from + timeunit_proc.call(i)
    end
  end

  def repeat_once!
    Repeat.create(event: self, datetime: from)
  end
end
